Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4201A48E694
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 09:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbiANIdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 03:33:20 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:34186 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbiANIdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 03:33:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7B6A8CE2184;
        Fri, 14 Jan 2022 08:33:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A63C36AE9;
        Fri, 14 Jan 2022 08:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642149196;
        bh=Svwyq65BGMvvbbIkTvnv43hNqr5O7jjy9V6Rmaw2jUY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=gHJo52TScjwc3U4B8s1aLQei7JnkP3zJuGrfuYP1Mweo2ibjJX6df6jnasGUdAAxo
         bnh0k/9NhYTGjME0W4szIHyZ7ZgShaFhARgjZ0YPECvwUiA5s3xwyStMeH+2vuOex+
         iKMir/qaAPM1CD50lC5bsIWEyQiV1YvZE0ovlMhvH333eO4ycWFdp9NmnvYHWK1P+h
         dcS7F8B1rOqDejLERR8vPLz2wyZb8LtOLmhhJ7qX+HSCX7VH8m87zatUE2l/Edec4e
         zCI+CpeAmuxS09zirQaSKKkgxfXtR6/flfnYf7+mCNi1qkjjg4lSo6RBLlHRhG8G8r
         bxvk5f6wYKg/A==
Date:   Fri, 14 Jan 2022 09:33:12 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Sean O'Brien <seobrien@chromium.org>,
        Ting Shen <phoenixshen@google.com>,
        Stephen Boyd <swboyd@google.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: vivaldi: fix handling devices not using numbered
 reports
In-Reply-To: <YdieAFj0ppmAtQxS@google.com>
Message-ID: <nycvar.YFH.7.76.2201140932160.28059@cbobk.fhfr.pm>
References: <YdieAFj0ppmAtQxS@google.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jan 2022, Dmitry Torokhov wrote:

> Unfortunately details of USB HID transport bled into HID core and
> handling of numbered/unnumbered reports is quite a mess, with
> hid_report_len() calculating the length according to USB rules,
> and hid_hw_raw_request() adding report ID to the buffer for both
> numbered and unnumbered reports.

Yeah, I agree that's unfortunate, and untangling this has been on my TODO 
for quite some time :/

> Fixes: 14c9c014babe ("HID: add vivaldi HID driver")
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> CrOS folks, please help testing this as I do not have the affected
> hardware.
> 
> Thanks!
> 
>  drivers/hid/hid-vivaldi.c | 34 ++++++++++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hid/hid-vivaldi.c b/drivers/hid/hid-vivaldi.c
> index cd7ada48b1d9..1804de1ef9b8 100644
> --- a/drivers/hid/hid-vivaldi.c
> +++ b/drivers/hid/hid-vivaldi.c
> @@ -71,10 +71,11 @@ static void vivaldi_feature_mapping(struct hid_device *hdev,
>  				    struct hid_usage *usage)
>  {
>  	struct vivaldi_data *drvdata = hid_get_drvdata(hdev);
> +	struct hid_report *report = field->report;
>  	int fn_key;
>  	int ret;
>  	u32 report_len;
> -	u8 *buf;
> +	u8 *report_data, *buf;
>  
>  	if (field->logical != HID_USAGE_FN_ROW_PHYSMAP ||
>  	    (usage->hid & HID_USAGE_PAGE) != HID_UP_ORDINAL)
> @@ -86,12 +87,24 @@ static void vivaldi_feature_mapping(struct hid_device *hdev,
>  	if (fn_key > drvdata->max_function_row_key)
>  		drvdata->max_function_row_key = fn_key;
>  
> -	buf = hid_alloc_report_buf(field->report, GFP_KERNEL);
> -	if (!buf)
> +	report_data = buf = hid_alloc_report_buf(report, GFP_KERNEL);
> +	if (!report_data)
>  		return;
>  
> -	report_len = hid_report_len(field->report);
> -	ret = hid_hw_raw_request(hdev, field->report->id, buf,
> +	report_len = hid_report_len(report);
> +	if (!report->id) {
> +		/*
> +		 * hid_hw_raw_request() will stuff report ID (which will be 0)
> +		 * into the first byte of the buffer even for unnumbered
> +		 * reports, so we need to account for this to avoid getting
> +		 * -EOVERFLOW in return.
> +		 * Note that hid_alloc_report_buf() adds 7 bytes to the size
> +		 * so we can safely say that we have space for an extra byte.
> +		 */
> +		report_len++;
> +	}
> +
> +	ret = hid_hw_raw_request(hdev, field->report->id, report_data,

I've changed this to report->id and applied, thanks.

-- 
Jiri Kosina
SUSE Labs


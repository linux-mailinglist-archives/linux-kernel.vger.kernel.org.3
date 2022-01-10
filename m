Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD01648931C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239875AbiAJIOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbiAJIOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:14:39 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDD3C06173F;
        Mon, 10 Jan 2022 00:14:39 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id c14-20020a17090a674e00b001b31e16749cso20018404pjm.4;
        Mon, 10 Jan 2022 00:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xN1vtAyh+kwI83JTVy+mkGHjlZGHaJa9aANamWLa06M=;
        b=TIDkriRBhYYvmbd1QbK8yfZ29G2Ssa6/Il2alwx/UJko/44M150ltIrZd9tlsExply
         EPe9GwL9vkk8hpeVzZlB7Ftr1tJF57o2aD2NSpf9oj90G7V9BuL51rYr/fis5aA+Slgf
         totHpWMOjsYh5vbG9GN5baAL1uvAalyN8jXxju9PKiLAWzsUKNgn3/FTj7prFqaQp0OP
         IvGily4+3Jcqc7vj8dCx72ehwAL/K4Db0UjJlcxjzofaZL4JeVn6R2kwdb2v5ktG3Cqv
         QsQMLq+V0oOmFy+GovSpGFu4ctiQQvDNn4L05LtDibHjnxummFPmbqnYV8jCi6uv5poa
         7M3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xN1vtAyh+kwI83JTVy+mkGHjlZGHaJa9aANamWLa06M=;
        b=29ebhFDSlIa3ceh1wRdDgeS7UmgK97G1ycSLWnJUr0uK1guP04l9zwcG0P4C8ZixWH
         e29NTJhQ52dBfPNoTBnol4o2x4dz4KFI6laeVAvC5Vs+Bhvi9hha4wF7ci2MGdjTa24U
         9g37Ny6AeytdYt2wOwnvZ1urFv4jsx4yHpjo0DBHdy/jzDvI76xNp1RTQR9xpXhd5t49
         0yeL9lrFGwdHic4E73zwaT+FNv+UoalP0JXaAtJUaTGok5Dq0vzLka10POvSX40bY34G
         Hj2/H7rndKUHhEpMMbqFVVOHkBylTtblXn2/EquzewiABd/0CqZkNn8QTWiStWKUf9sd
         HHGA==
X-Gm-Message-State: AOAM533+GpxLHXmHOYCUZGFR6KCVCOV+JDpbrtMZ/FzsWtAqXwxp4Gfn
        rr70GTHCRFDjYaB6QfhUxb0=
X-Google-Smtp-Source: ABdhPJxOsLGlBEucz1/2525I+3enC/3LGB3tNEm52E/BDyRSXKVPxCxb8353YYhp9dRuvYgv1nZmZw==
X-Received: by 2002:a17:90a:6c05:: with SMTP id x5mr10454391pjj.61.1641802478491;
        Mon, 10 Jan 2022 00:14:38 -0800 (PST)
Received: from google.com ([2620:15c:202:201:1d28:509e:281:5bca])
        by smtp.gmail.com with ESMTPSA id a3sm5929723pfv.47.2022.01.10.00.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 00:14:36 -0800 (PST)
Date:   Mon, 10 Jan 2022 00:14:34 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Sean O'Brien <seobrien@chromium.org>,
        Ting Shen <phoenixshen@google.com>,
        Stephen Boyd <swboyd@google.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: vivaldi: fix handling devices not using numbered
 reports
Message-ID: <Ydvq6sgHzNzAy0ud@google.com>
References: <YdieAFj0ppmAtQxS@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdieAFj0ppmAtQxS@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 12:09:36PM -0800, Dmitry Torokhov wrote:
> Unfortunately details of USB HID transport bled into HID core and
> handling of numbered/unnumbered reports is quite a mess, with
> hid_report_len() calculating the length according to USB rules,
> and hid_hw_raw_request() adding report ID to the buffer for both
> numbered and unnumbered reports.
> 
> Untangling it all requres a lot of changes in HID, so for now let's
> handle this in the driver.
> 
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

This can be changed to "report->id", sorry I missed it.

>  				 report_len, HID_FEATURE_REPORT,
>  				 HID_REQ_GET_REPORT);
>  	if (ret < 0) {
> @@ -100,7 +113,16 @@ static void vivaldi_feature_mapping(struct hid_device *hdev,
>  		goto out;
>  	}
>  
> -	ret = hid_report_raw_event(hdev, HID_FEATURE_REPORT, buf,
> +	if (!report->id) {
> +		/*
> +		 * Undo the damage from hid_hw_raw_request() for unnumbered
> +		 * reports.
> +		 */
> +		report_data++;
> +		report_len--;
> +	}
> +
> +	ret = hid_report_raw_event(hdev, HID_FEATURE_REPORT, report_data,
>  				   report_len, 0);
>  	if (ret) {
>  		dev_warn(&hdev->dev, "failed to report feature %d\n",

Thanks.

-- 
Dmitry

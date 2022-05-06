Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E943651D1AB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 08:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386666AbiEFG6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 02:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242356AbiEFG6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 02:58:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6CA66C97;
        Thu,  5 May 2022 23:54:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1D8BB833ED;
        Fri,  6 May 2022 06:53:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBEE4C385AA;
        Fri,  6 May 2022 06:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651820026;
        bh=RDAFgC/kLKVa48KVPSFQKH5qA2Q3DdLdg22SA13WBkU=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=AOXgbloBscUEk/HUdnXLTZ2ScyHSV5kypj6P/Q+LUZNVp6vhyzo3N5ypy4uemW5Xv
         wD2lot3lvtVrVJfEeigqyoc26bX2wpI6g9LxC6dutn0u027EsdYmxzvAQQYN6nWmwX
         SeTwZuLUAuPEQquDlp8vao16Kjy4eAisupQEoxYcnEo0z8MvrLviYBNj/4+vHA3XuZ
         bSC4ipaKB30BX/ogWs5rMYOQa0TnT6hP27NznZAqEEY1DaywRqBv8gMEsDHck4tWOI
         m3WN6NcvYObhNYU/dsx2uinvcrqxVDhBRYTGVmFqbtXF1QlVSBJoPH5BxHB4lZDoAy
         NU9KqwOhbuGVA==
Date:   Fri, 6 May 2022 08:53:42 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Dongliang Mu <dzm91@hust.edu.cn>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        syzkaller <syzkaller@googlegroups.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: bigben: fix slab-out-of-bounds Write in
 bigben_probe
In-Reply-To: <20220506053740.1113415-1-dzm91@hust.edu.cn>
Message-ID: <nycvar.YFH.7.76.2205060852300.28985@cbobk.fhfr.pm>
References: <20220506053740.1113415-1-dzm91@hust.edu.cn>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 May 2022, Dongliang Mu wrote:

> From: Dongliang Mu <mudongliangabcd@gmail.com>
> 
> There is a slab-out-of-bounds Write bug in hid-bigbenff driver.
> The problem is the driver assumes the device must have an input but
> some malicious devices violate this assumption.
> 
> Fix this by checking hid_device's input is non-empty before its usage.
> 
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
>  drivers/hid/hid-bigbenff.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/hid/hid-bigbenff.c b/drivers/hid/hid-bigbenff.c
> index 74ad8bf98bfd..c14d1774101d 100644
> --- a/drivers/hid/hid-bigbenff.c
> +++ b/drivers/hid/hid-bigbenff.c
> @@ -347,6 +347,11 @@ static int bigben_probe(struct hid_device *hid,
>  	bigben->report = list_entry(report_list->next,
>  		struct hid_report, list);
>  
> +	if (list_empty(&hid->inputs)) {
> +		hid_err(hid, "no inputs found\n");
> +		return -ENODEV;
> +	}
> +

Thanks for the fix. It doesn't seemt o be fully correct though -- as you'd 
be returning -ENODEV here in the situation when hid_hw_start() has already 
happened. So I believe better thing to do here is to do error = -ENODEV; 
goto error_hw_stop;

Could you please fix that up and resend? Thanks,

-- 
Jiri Kosina
SUSE Labs


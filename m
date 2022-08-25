Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442B05A0CA2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbiHYJaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234415AbiHYJaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:30:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB7254669;
        Thu, 25 Aug 2022 02:30:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE05861BE6;
        Thu, 25 Aug 2022 09:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1ACBC433D6;
        Thu, 25 Aug 2022 09:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661419811;
        bh=L+0sXmx3plDatFgNg4UJoNuIQ/1S5Vx8B0Xd9YUiaZ8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=RficcT4mEcQK7KICgYfApQfkkwbhkoNIXWvgSNZBHQwxDMUuPe8nLksV3+nsoWiXi
         INl4jOWJNbt8JA+d9a4LHowOOuCH4dcAKeJiVfwqPJ1IObit0z9qjmHVJQLoh8PDBy
         wG1k21fNEWDYQZbUuVwoeAY585DVqJMU3vkinUzfGrQjdbf7i3hwlxyyl1D+YbUxAp
         05JYjVbKzSjioxsRK/zbDx0+C4jQfh23baof986uVXGqH6OdUymxqp8hMGMZDORaOI
         6arWSoVJVpaM++wsBbnf7nw+bppAanXXEk7lgtazOgGOicGFDqun2b+DaaffQ0VAQ2
         +f3UbxTps1tXw==
Date:   Thu, 25 Aug 2022 11:30:07 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Jiangshan Yi <13667453960@163.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiangshan Yi <yijiangshan@kylinos.cn>
Subject: Re: [PATCH] HID: rmi: replace ternary operator with min()
In-Reply-To: <20220713032047.2238205-1-13667453960@163.com>
Message-ID: <nycvar.YFH.7.76.2208251129590.19850@cbobk.fhfr.pm>
References: <20220713032047.2238205-1-13667453960@163.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2022, Jiangshan Yi wrote:

> From: Jiangshan Yi <yijiangshan@kylinos.cn>
> 
> Fix the following coccicheck warning:
> 
> drivers/hid/hid-rmi.c:240: WARNING opportunity for min().
> drivers/hid/hid-rmi.c:350: WARNING opportunity for min().
> 
> min() macro is defined in include/linux/minmax.h. It avoids
> multiple evaluations of the arguments when non-constant and performs
> strict type-checking.
> 
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
> ---
>  drivers/hid/hid-rmi.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
> index 311eee599ce9..bb1f423f4ace 100644
> --- a/drivers/hid/hid-rmi.c
> +++ b/drivers/hid/hid-rmi.c
> @@ -237,8 +237,7 @@ static int rmi_hid_read_block(struct rmi_transport_dev *xport, u16 addr,
>  
>  			read_input_count = data->readReport[1];
>  			memcpy(buf + bytes_read, &data->readReport[2],
> -				read_input_count < bytes_needed ?
> -					read_input_count : bytes_needed);
> +				min(read_input_count, bytes_needed));
>  
>  			bytes_read += read_input_count;
>  			bytes_needed -= read_input_count;
> @@ -347,8 +346,7 @@ static int rmi_read_data_event(struct hid_device *hdev, u8 *data, int size)
>  		return 0;
>  	}
>  
> -	memcpy(hdata->readReport, data, size < hdata->input_report_size ?
> -			size : hdata->input_report_size);
> +	memcpy(hdata->readReport, data, min((u32)size, hdata->input_report_size));
>  	set_bit(RMI_READ_DATA_PENDING, &hdata->flags);
>  	wake_up(&hdata->wait);

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs


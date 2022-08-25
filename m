Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7084A5A0CAB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240351AbiHYJcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240188AbiHYJb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:31:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43AD97D74;
        Thu, 25 Aug 2022 02:31:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF3A661BDF;
        Thu, 25 Aug 2022 09:31:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44700C433C1;
        Thu, 25 Aug 2022 09:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661419915;
        bh=kQ+7EJOiXSBW5POE9hfOgVfz2rzI/eDdTq6LvSFO37Y=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=pkawkFScZat7f6igWV8BasrNXsD4oAVxWX3iHw+Y9u0d5L9Relq1sDz9CiuHqroAD
         XGGQ8IaszbnkIn7VPdnNtCXQ8e1zpvPBpZj/FB1rqkZpacJTbf4Gq8FhEoS5Jbo+1E
         nhqFx0E94k5HU54PfCCe/nY25Wlt7ADXhD2FovIRtG87wcorVlexkfUV7UxJoaHQ2e
         He0ka/xATMkV/suoj7J2V1NbGHaj6yMvAIYgJ34YbWicdOIrb9Ud/DUWU8f8krA4jW
         54HNbISwCra5CawZpcVGbUHrUk4zNKI348FuKWSQF24r36YWyCdh08G9/QVO99EN3s
         94MovDjD7BQcQ==
Date:   Thu, 25 Aug 2022 11:31:51 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Josh Kilmer <srjek2@gmail.com>
cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2 RESEND] hid: asus: ROG NKey: Ignore portion of 0x5a
 report
In-Reply-To: <20220728175111.18769-1-srjek2@gmail.com>
Message-ID: <nycvar.YFH.7.76.2208251131460.19850@cbobk.fhfr.pm>
References: <CAMXW6=97T1tzT=FSyzZN6jBAKgzUDOjqRoH-FMAPLHk1gsD=mA@mail.gmail.com> <20220728175111.18769-1-srjek2@gmail.com>
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

On Thu, 28 Jul 2022, Josh Kilmer wrote:

> On an Asus G513QY, of the 5 bytes in a 0x5a report, only the first byte
> is a meaningful keycode. The other bytes are zeroed out or hold garbage
> from the last packet sent to the keyboard.
> 
> This patch fixes up the report descriptor for this event so that the
> general hid code will only process 1 byte for keycodes, avoiding
> spurious key events and unmapped Asus vendor usagepage code warnings.
> 
> Signed-off-by: Josh Kilmer <srjek2@gmail.com>
> ---
>  drivers/hid/hid-asus.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 08c9a9a60ae4..b59c3dafa6a4 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -1212,6 +1212,13 @@ static __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
>  		rdesc = new_rdesc;
>  	}
>  
> +	if (drvdata->quirks & QUIRK_ROG_NKEY_KEYBOARD &&
> +			*rsize == 331 && rdesc[190] == 0x85 && rdesc[191] == 0x5a &&
> +			rdesc[204] == 0x95 && rdesc[205] == 0x05) {
> +		hid_info(hdev, "Fixing up Asus N-KEY keyb report descriptor\n");
> +		rdesc[205] = 0x01;
> +	}
> +

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs


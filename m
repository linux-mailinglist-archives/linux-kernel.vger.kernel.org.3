Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED944AE6E6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 03:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344076AbiBICk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 21:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237043AbiBICEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 21:04:09 -0500
Received: from relay.hostedemail.com (relay.hostedemail.com [64.99.140.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007EEC06157B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 18:04:07 -0800 (PST)
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay11.hostedemail.com (Postfix) with ESMTP id 166AA80DE7;
        Wed,  9 Feb 2022 02:04:06 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id 5104430;
        Wed,  9 Feb 2022 02:03:43 +0000 (UTC)
Message-ID: <d7d764a70d154030fc5e00d6238c8a65b489e456.camel@perches.com>
Subject: Re: [PATCH] HID: lenovo: replace snprintf with sysfs_emit
From:   Joe Perches <joe@perches.com>
To:     davidcomponentone@gmail.com, jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Date:   Tue, 08 Feb 2022 18:03:58 -0800
In-Reply-To: <124b72fd0751d7f37c64dd517d386db38cf8c189.1644287860.git.yang.guang5@zte.com.cn>
References: <124b72fd0751d7f37c64dd517d386db38cf8c189.1644287860.git.yang.guang5@zte.com.cn>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: iqs1qxbfo9mznhfqx76ia7kbcdqcigeo
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 5104430
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18ty/e3+hs8eD8Zb+lkmqGKEYhRakpImEY=
X-HE-Tag: 1644372223-671604
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-02-09 at 08:39 +0800, davidcomponentone@gmail.com wrote:
> From: Yang Guang <yang.guang5@zte.com.cn>
[]
> Use sysfs_emit instead of scnprintf or sprintf makes more sense.
[]
> diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
[]
> @@ -442,7 +442,7 @@ static ssize_t attr_sensitivity_show_cptkbd(struct device *dev,
>  	struct hid_device *hdev = to_hid_device(dev);
>  	struct lenovo_drvdata *cptkbd_data = hid_get_drvdata(hdev);
>  
> -	return snprintf(buf, PAGE_SIZE, "%u\n",
> +	return sysfs_emit(buf, "%u\n",
>  		cptkbd_data->sensitivity);

Please rewrap lines to 80 columns where reasonable.

	return sysfs_emit(buf, "%u\n", cptkbd_data->sensitivity);

[]
> @@ -723,7 +723,7 @@ static ssize_t attr_sensitivity_show_tpkbd(struct device *dev,
>  	struct hid_device *hdev = to_hid_device(dev);
>  	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
>  
> -	return snprintf(buf, PAGE_SIZE, "%u\n",
> +	return sysfs_emit(buf, "%u\n",
>  		data_pointer->sensitivity);
>  }
>  
> @@ -752,7 +752,7 @@ static ssize_t attr_press_speed_show_tpkbd(struct device *dev,
>  	struct hid_device *hdev = to_hid_device(dev);
>  	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
>  
> -	return snprintf(buf, PAGE_SIZE, "%u\n",
> +	return sysfs_emit(buf, "%u\n",
>  		data_pointer->press_speed);

etc...



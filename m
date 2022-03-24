Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B3F4E5ED6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 07:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242950AbiCXGmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 02:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234676AbiCXGmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 02:42:44 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FA5E0F2;
        Wed, 23 Mar 2022 23:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648104066;
        bh=oG+rbJAm+AG9M3LiDWs+HaYi73GayH2tAZGdv8/RRoI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=S2FF7aE5pEQs5rGsjp5rWb8851LRaSn3D138pQfabvVTv6DOKSLG/CgBW11bg+f6h
         HL0Q7P1nl51t+rmMcrE5mOtq7xXv3e5Y4w1nVoffAN8Mly+vyYOr0eAg71zI+tPKZN
         KhW2b0NkrKejxzkBQEsb0COk6A4LcYlVioq6CSvM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.161.116]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7i8Y-1oBe0e1vGs-014lkP; Thu, 24
 Mar 2022 07:41:06 +0100
Message-ID: <4ff1bba5-3645-97b3-da66-8d413b8db2e1@gmx.de>
Date:   Thu, 24 Mar 2022 07:41:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] fbdev: udlfb: properly check endpoint type
Content-Language: en-US
To:     Pavel Skripkin <paskripkin@gmail.com>, bernie@plugable.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        syzbot+53ce4a4246d0fe0fee34@syzkaller.appspotmail.com
References: <20220322200438.17998-1-paskripkin@gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220322200438.17998-1-paskripkin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/XAFFZp6PO9BerQtIDwhx4StVjl+zIed3G1ZiAVxV6TfGCJ278T
 6lRU7el1gK+zDoXGRntW9+339zS3dkq7gIF08JA2sKwGSbfkr8NyLnm35ZPCG2defmuk3B9
 NO0Wx8e7Q/jK+gUh86mvKix8UwGhLojF+P/MkSjqorMA6uhGb5AFCwjT/noechHtSdwXAyr
 t3RqATF8peyc284A57WBw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JD9Gtfjzj/E=:RyuRtZUGCHF4aZncS5zsFR
 DtiIGqJh5M9P5O4i0l0kS0VM1OWDJbO81jQN6sHqlGAU0Z1Ai5VZgWk3Sn1BLVUHm+GJBLI+D
 OtdI1BI1sGjJYfwK6FlNLglmvx2dNXJk93S9YlcWOu4LaSIUm+eqIS+pCUrgS5fkWg3+CAgEE
 zdyBPy5vMrwooXZGTEle9xrMKC2IFUfBKBrleTLK3/lbacpVndAPrWdZLYJzRiiIT0jNacgAU
 M/FoSXAPlcQ72xUZs551UCGB+B4MJ7l4tOs3DlfjTvmLXCtDxTd886C7SMt5nCIHa3FBsxNmg
 37mnHE12kltm5zQhZeAX4xF9NVsq5vO7uHZW9RwMb1PuJTtmplUPkPIQcQ0XRwjcNXm5DQwJj
 QLswcaNE+uYFZC2f0ZKGK0qB9Rr8Hy0e//8e80COrVQoRP9wJ1Y9vbnRl1xGZNYyDFEwWNfu4
 QXzEULN5Yo47CcAeXr8u//G1x4uWfzkTeQevjJID2yjGQ94Z7h9729GvpIC2MVUCXOrdwneNK
 NPoZuJCuTc8PKKiOjjrIaV0Vkje0oGVRSxRVvB5n8d4h4esbWrPpKt1QSUE7SUzB9PeN/PYdZ
 jUrIqaLxkdqbWTbE1Czd+hvzE6ExqqLsXYzhZjrr71D9cdcXFs1UPevV6FRJqCRu9QF2n8Ja8
 mdepWhUcbM20IcF+9716X1Y3dw9I2cm0YvDg6WmRAYGmvR01GmUPWyqa1u5UHw/lXkzznHmj4
 JesSi5FHjiMplAqctvhdzQ5uiX+cNYyOQBSAglDVx4OMkjyzW50o6R62pLNnzUFlS+K7tCzEr
 8sGo9eJaglz4Q6D8ecTBQ0j2l0WwIlMQCquUtGCBOysPIEn8jBfGjnuGsxJtuVCN0bDj/AwwB
 sFh/WutqW2dcciFl152dbq/0Nt2H05M4M7hs4ulV5wnpUfH6sVWq7H+RIcKb5dN0tTc1oM5ZX
 DI4i4arQmHHvzc3EixNMsvOi5SfUulFySdIF8fm4smzpXLp4kZH5uF54ibBgYn9D5ri61eelY
 C2Nhg1tjtG1fVlXsZVN/SWXaQNHTL3fdFcYppbwYSqHTHfS/RZEnD/q207i+B9LOVQJJ3Cike
 Iv1cT3hVQ/ZEiA=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/22 21:04, Pavel Skripkin wrote:
> syzbot reported warning in usb_submit_urb, which is caused by wrong
> endpoint type.
>
> This driver uses out bulk endpoint for communication, so
> let's check if this endpoint is present and bail out early if not.
>
> Fail log:
>
> usb 1-1: BOGUS urb xfer, pipe 3 !=3D type 1
> WARNING: CPU: 0 PID: 4822 at drivers/usb/core/urb.c:493 usb_submit_urb+0=
xd27/0x1540 drivers/usb/core/urb.c:493
> Modules linked in:
> CPU: 0 PID: 4822 Comm: kworker/0:3 Tainted: G        W         5.13.0-sy=
zkaller #0
> ...
> Workqueue: usb_hub_wq hub_event
> RIP: 0010:usb_submit_urb+0xd27/0x1540 drivers/usb/core/urb.c:493
> ...
> Call Trace:
>  dlfb_submit_urb+0x89/0x160 drivers/video/fbdev/udlfb.c:1969
>  dlfb_set_video_mode+0x21f0/0x2950 drivers/video/fbdev/udlfb.c:315
>  dlfb_ops_set_par+0x2a3/0x840 drivers/video/fbdev/udlfb.c:1110
>  dlfb_usb_probe.cold+0x113e/0x1f4a drivers/video/fbdev/udlfb.c:1732
>  usb_probe_interface+0x315/0x7f0 drivers/usb/core/driver.c:396
>
> Fixes: 88e58b1a42f8 ("Staging: add udlfb driver")
> Reported-and-tested-by: syzbot+53ce4a4246d0fe0fee34@syzkaller.appspotmai=
l.com
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>

applied.

Thanks,
Helge

> ---
>  drivers/video/fbdev/udlfb.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
> index b9cdd02c1000..2343c7955747 100644
> --- a/drivers/video/fbdev/udlfb.c
> +++ b/drivers/video/fbdev/udlfb.c
> @@ -1649,8 +1649,9 @@ static int dlfb_usb_probe(struct usb_interface *in=
tf,
>  	const struct device_attribute *attr;
>  	struct dlfb_data *dlfb;
>  	struct fb_info *info;
> -	int retval =3D -ENOMEM;
> +	int retval;
>  	struct usb_device *usbdev =3D interface_to_usbdev(intf);
> +	struct usb_endpoint_descriptor *out;
>
>  	/* usb initialization */
>  	dlfb =3D kzalloc(sizeof(*dlfb), GFP_KERNEL);
> @@ -1664,6 +1665,12 @@ static int dlfb_usb_probe(struct usb_interface *i=
ntf,
>  	dlfb->udev =3D usb_get_dev(usbdev);
>  	usb_set_intfdata(intf, dlfb);
>
> +	retval =3D usb_find_common_endpoints(intf->cur_altsetting, NULL, &out,=
 NULL, NULL);
> +	if (retval) {
> +		dev_err(&intf->dev, "Device should have at lease 1 bulk endpoint!\n")=
;
> +		goto error;
> +	}
> +
>  	dev_dbg(&intf->dev, "console enable=3D%d\n", console);
>  	dev_dbg(&intf->dev, "fb_defio enable=3D%d\n", fb_defio);
>  	dev_dbg(&intf->dev, "shadow enable=3D%d\n", shadow);
> @@ -1673,6 +1680,7 @@ static int dlfb_usb_probe(struct usb_interface *in=
tf,
>  	if (!dlfb_parse_vendor_descriptor(dlfb, intf)) {
>  		dev_err(&intf->dev,
>  			"firmware not recognized, incompatible device?\n");
> +		retval =3D -ENODEV;
>  		goto error;
>  	}
>
> @@ -1686,8 +1694,10 @@ static int dlfb_usb_probe(struct usb_interface *i=
ntf,
>
>  	/* allocates framebuffer driver structure, not framebuffer memory */
>  	info =3D framebuffer_alloc(0, &dlfb->udev->dev);
> -	if (!info)
> +	if (!info) {
> +		retval =3D -ENOMEM;
>  		goto error;
> +	}
>
>  	dlfb->info =3D info;
>  	info->par =3D dlfb;


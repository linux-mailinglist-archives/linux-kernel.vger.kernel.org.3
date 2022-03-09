Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F634D3DCE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 00:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237020AbiCJAAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 19:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiCJAAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 19:00:41 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C13FCE939;
        Wed,  9 Mar 2022 15:59:42 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id j12so2696583ils.0;
        Wed, 09 Mar 2022 15:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3P8g9u3vJUtm4A9yAvYJk4LsJmcVg6YYa9BoxTi+5uE=;
        b=UYB0QDw15gPlPJVL+6PbqKCH9nJX4RkIyvB2ggYwFNGBCw3OdqQuuUIeWu8mihMlq9
         hrDBH475fvEbUuFqBhvmTe1AmV1CbVuJpJjZhw5aSKvS5vxPyRwFUvHbSC64r6rWVYut
         n0jbh1OIVxEl2raescQuWJKbp3QpnWdZZ1sQbShnuCiR3g2E4d5qPY+g9o9+sfYRcfal
         lQZ8GUXQKLYkO2Jtj0atnzDg6KHB0JvC4wdR8ZNEImaf7ip7CkkiQmigsbJTcBB9xIqH
         F8t9QYpo/3VjSyDBXvL1InsQq510U9Up/J5xTXEb0M+urukRRgqfEV5yUCOfLSTAJYui
         IxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3P8g9u3vJUtm4A9yAvYJk4LsJmcVg6YYa9BoxTi+5uE=;
        b=tT3cfiilim6hy0RfdYy0ZTXmfF3rOPMti+Vnntn8m9lBARf50TnIipwAI3qDGBOBur
         v5jal/+q/0NceUrQX3zk44H21Os7mXXGVCxS5cQhOuCnlcPUhaXUrvG2pMHKEvAAxbk0
         ykET5fPIEOtVOyhxr+osNBCKkH11ZBqkZnLSh4jdYcs4KFuzWno4iV6pMYWJ3BjZGhMh
         iMCO5SxB5dOBuhxckwVqovzO/7QHpTbIrgnvX+VXpcR//5EaNYiZY2a9ENipXApQexOE
         MrHL+iQMEWCf5IKYfgicx3xsuSo6L/ll1ogexmFjiIf2jirLh7V/q3vwk2+aChcJ/x4Q
         3NLw==
X-Gm-Message-State: AOAM533qvzpC08oLksF8PuK7W+QRnsVE6n0vcuhI2yk1ILYpvow2Zirq
        M8NEmZmvEh2dtoA9YzPaOflN0yKFtXzAN/Z/R1JQM3E/b7E=
X-Google-Smtp-Source: ABdhPJwCn3UqWr0phlnPZ9sqqHZ276kAgETWITUftbU7qwrFqaSR3FSFMTK2H+dam0JN4lghiGM/8i9sPhK1OQCPaRo=
X-Received: by 2002:a92:cf42:0:b0:2c6:2e92:800a with SMTP id
 c2-20020a92cf42000000b002c62e92800amr1530365ilr.28.1646870381500; Wed, 09 Mar
 2022 15:59:41 -0800 (PST)
MIME-Version: 1.0
References: <20220308112832.6170-1-jj251510319013@gmail.com>
In-Reply-To: <20220308112832.6170-1-jj251510319013@gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 10 Mar 2022 00:59:29 +0100
Message-ID: <CA+fCnZd2GoU6LVvT4eBT3w7TigRrp_9XcAGyL55K5nbi3yt4sA@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: return -EINVAL if no proper ep address available
To:     Wei Ming Chen <jj251510319013@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000014bb2505d9d1e4ac"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000014bb2505d9d1e4ac
Content-Type: text/plain; charset="UTF-8"

On Tue, Mar 8, 2022 at 12:31 PM Wei Ming Chen <jj251510319013@gmail.com> wrote:
>

Hi,

The commit name should be prefixed with "usb: raw-gadget:".

> If we try to use raw_ioctl_ep_enable() for ep5in on a hardware that
> only support from ep1-ep4 for both in and out direction, it will return
> -EBUSY originally.
>
> I think it will be more intuitive if we return -EINVAL, Cuz -EBUSY sounds
> like ep5in is not available now, but might be available in the future.

Cuz -> because

>
> Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>
> ---
>  drivers/usb/gadget/legacy/raw_gadget.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
> index d86c3a36441e..b4cc083a7ca6 100644
> --- a/drivers/usb/gadget/legacy/raw_gadget.c
> +++ b/drivers/usb/gadget/legacy/raw_gadget.c
> @@ -758,6 +758,7 @@ static int raw_ioctl_ep_enable(struct raw_dev *dev, unsigned long value)
>         unsigned long flags;
>         struct usb_endpoint_descriptor *desc;
>         struct raw_ep *ep;
> +       bool ep_num_matched = false;
>
>         desc = memdup_user((void __user *)value, sizeof(*desc));
>         if (IS_ERR(desc))
> @@ -792,6 +793,7 @@ static int raw_ioctl_ep_enable(struct raw_dev *dev, unsigned long value)
>                 if (ep->addr != usb_endpoint_num(desc) &&
>                                 ep->addr != USB_RAW_EP_ADDR_ANY)
>                         continue;
> +               ep_num_matched = true;
>                 if (!usb_gadget_ep_match_desc(dev->gadget, ep->ep, desc, NULL))
>                         continue;
>                 ep->ep->desc = desc;
> @@ -815,6 +817,12 @@ static int raw_ioctl_ep_enable(struct raw_dev *dev, unsigned long value)
>                 goto out_unlock;
>         }
>
> +       if (!ep_num_matched) {
> +               dev_dbg(&dev->gadget->dev, "fail, no proper ep address available\n");
> +               ret = -EINVAL;
> +               goto out_free;
> +       }

Thinking more about this, we should cover the following cases:

1. If there are no endpoints that match the provided descriptor, return EINVAL.

2. If there are matching endpoints, but they are all already enabled,
return EBUSY.

A draft change is attached.

What do you think?

If the suggested change looks good, feel free to incorporate it into
the version 2 of your patch.

> +
>         dev_dbg(&dev->gadget->dev, "fail, no gadget endpoints available\n");
>         ret = -EBUSY;
>
> --
> 2.25.1
>

Thanks!

--00000000000014bb2505d9d1e4ac
Content-Type: text/x-patch; charset="US-ASCII"; name="raw-gadget-retval.patch"
Content-Disposition: attachment; filename="raw-gadget-retval.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l0k813tg0>
X-Attachment-Id: f_l0k813tg0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC9sZWdhY3kvcmF3X2dhZGdldC5jIGIvZHJp
dmVycy91c2IvZ2FkZ2V0L2xlZ2FjeS9yYXdfZ2FkZ2V0LmMKaW5kZXggZDg2YzNhMzY0NDFlLi5h
MGQ1ZWRmMWIyYzUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC9sZWdhY3kvcmF3X2dh
ZGdldC5jCisrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC9sZWdhY3kvcmF3X2dhZGdldC5jCkBAIC03
ODcsMTMgKzc4NywxNCBAQCBzdGF0aWMgaW50IHJhd19pb2N0bF9lcF9lbmFibGUoc3RydWN0IHJh
d19kZXYgKmRldiwgdW5zaWduZWQgbG9uZyB2YWx1ZSkKIAogCWZvciAoaSA9IDA7IGkgPCBkZXYt
PmVwc19udW07IGkrKykgewogCQllcCA9ICZkZXYtPmVwc1tpXTsKLQkJaWYgKGVwLT5zdGF0ZSAh
PSBTVEFURV9FUF9ESVNBQkxFRCkKLQkJCWNvbnRpbnVlOwogCQlpZiAoZXAtPmFkZHIgIT0gdXNi
X2VuZHBvaW50X251bShkZXNjKSAmJgogCQkJCWVwLT5hZGRyICE9IFVTQl9SQVdfRVBfQUREUl9B
TlkpCiAJCQljb250aW51ZTsKIAkJaWYgKCF1c2JfZ2FkZ2V0X2VwX21hdGNoX2Rlc2MoZGV2LT5n
YWRnZXQsIGVwLT5lcCwgZGVzYywgTlVMTCkpCiAJCQljb250aW51ZTsKKwkJZXBfcHJvcHNfbWF0
Y2hlZCA9IHRydWU7CisJCWlmIChlcC0+c3RhdGUgIT0gU1RBVEVfRVBfRElTQUJMRUQpCisJCQlj
b250aW51ZTsKIAkJZXAtPmVwLT5kZXNjID0gZGVzYzsKIAkJcmV0ID0gdXNiX2VwX2VuYWJsZShl
cC0+ZXApOwogCQlpZiAocmV0IDwgMCkgewpAQCAtODE1LDggKzgxNiwxMyBAQCBzdGF0aWMgaW50
IHJhd19pb2N0bF9lcF9lbmFibGUoc3RydWN0IHJhd19kZXYgKmRldiwgdW5zaWduZWQgbG9uZyB2
YWx1ZSkKIAkJZ290byBvdXRfdW5sb2NrOwogCX0KIAotCWRldl9kYmcoJmRldi0+Z2FkZ2V0LT5k
ZXYsICJmYWlsLCBubyBnYWRnZXQgZW5kcG9pbnRzIGF2YWlsYWJsZVxuIik7Ci0JcmV0ID0gLUVC
VVNZOworCWlmICghZXBfcHJvcHNfbWF0Y2hlZCkKKwkJZGV2X2RiZygmZGV2LT5nYWRnZXQtPmRl
diwgImZhaWwsIGJhZCBlbmRwb2ludCBkZXNjcmlwdG9yXG4iKTsKKwkJcmV0ID0gLUVJTlZBTDsK
Kwl9IGVsc2UgeworCQlkZXZfZGJnKCZkZXYtPmdhZGdldC0+ZGV2LCAiZmFpbCwgbm8gZW5kcG9p
bnRzIGF2YWlsYWJsZVxuIik7CisJCXJldCA9IC1FQlVTWTsKKwl9CiAKIG91dF9mcmVlOgogCWtm
cmVlKGRlc2MpOwo=
--00000000000014bb2505d9d1e4ac--

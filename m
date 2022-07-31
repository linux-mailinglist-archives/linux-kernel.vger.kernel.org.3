Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE7C585EAE
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 13:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236631AbiGaLqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 07:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiGaLqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 07:46:05 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8BB10562
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 04:46:02 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-10cf9f5b500so10643524fac.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 04:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=Kj6cBvNirPBOcR0RNx1S0sycN75ulvqnQVOku/MwN8Y=;
        b=NAsA92Fcf9V01k3u2OQiLynjFaA0zAgcMmRK33Ffuzw58xh9eay4H6F3z3zweH9Uq7
         6MIkCFS63jrNdg4oXsS6lTvTHn7YrzXHki28xnYQEtYQnu/LNZIVwUzAjIIzUo0gPqv5
         EmfZsAm6e4DJWaIQXVwa7nRx7Ti9S7/skQVG36k9nEedZg778+Zx4JBy+bRZqxBIshoT
         F5lZOjLomKCan+WNTPZHvkoDlujA7bEYTYaXxKuH9bAxgDD8Zrn8G2TdTn7ft5lqgiKD
         S8WK2gbGT3qrOScS4y7/IybhxAHxJB01wPANZKYyHifeCYg6jreXHols3Uy1XmnaDIqS
         crRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=Kj6cBvNirPBOcR0RNx1S0sycN75ulvqnQVOku/MwN8Y=;
        b=6JUbuqtRmAXAYJGz9UEDthfAVygG59849kMqBQlIKpLXBgAaMvggZ+xba6ehah8Ci9
         rcQ+fTyMe+XEEO+H7bY+ksg4QNVI6GPA9xH1lGFlcVcBR+Bq4HEM3Nwjgy3CVhFiANxz
         4qE5uvMETsqUU/mKzjdNnxybcQhXq2xVDXb2FMLrGDQ+d1fjanerQNy9yBbudzVbgiGT
         djYbPxUQRCto5V+trPMZEj2nGOUBn9PeS3dO8D4d7tDqXdmquJpGR6XtB1CPTvsCi5gu
         3R2Zovb9DN97kiRFZ/5hLQTX/Uq2CZbjmY5EtDKWgSmFGiYLOS9ZwB49WcwzanIBxLf9
         AZcg==
X-Gm-Message-State: AJIora+Z46Cpp/K8d9ND/bkz93I63xbjIGpvRXVTwr38Ya0rY/YTR8LO
        TsqXW+I0cdm+N+mADc8uvY337ZDMiM3JPzNtggAJ2qZSm9nMGw==
X-Google-Smtp-Source: AGRyM1uwlLq6GcFjL0Nvi3y/OKIqcimzjP8cngE+cghI08E9EqLUuQG4Nj9ITaWy6uRRkifSrKycg1ZitQnUkLWlNSI=
X-Received: by 2002:a05:6870:9193:b0:10d:130e:e57c with SMTP id
 b19-20020a056870919300b0010d130ee57cmr5561405oaf.286.1659267960847; Sun, 31
 Jul 2022 04:46:00 -0700 (PDT)
MIME-Version: 1.0
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Sun, 31 Jul 2022 14:45:34 +0300
Message-ID: <CAFCwf11=9qpNAepL7NL+YAV_QO=Wv6pnWPhKHKAepK3fNn+2Dg@mail.gmail.com>
Subject: New subsystem for acceleration devices
To:     Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Jiho Chu <jiho.chu@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Greg and I talked a couple of months ago about preparing a new accel
subsystem for compute/acceleration devices that are not GPUs and I
think your drivers that you are now trying to upstream fit it as well.

Would you be open/interested in migrating your drivers to this new subsystem ?

Because there were no outstanding candidates, I have done so far only
a basic and partial implementation of the infrastructure for this
subsystem, but if you are willing to join I believe I can finish it
rather quickly.

At start, the new subsystem will provide only a common device
character (e.g. /dev/acX) so everyone will do open/close/ioctl on the
same device character. Also sysfs/debugfs entries will be under that
device and maybe an IOCTL to retrieve information.

In the future I plan to move some of habanalabs driver's code into the
subsystem itself, for common tasks such as memory management, dma
memory allocation, etc.

Of course, you will be able to add your own IOCTLs as you see fit.
There will be a range of IOCTLs which are device-specific (similar to
drm).

wdyt ?

Thanks,
Oded

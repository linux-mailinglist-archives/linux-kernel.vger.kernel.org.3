Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E265800DE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 16:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbiGYOjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 10:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235747AbiGYOjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 10:39:08 -0400
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EE017A8F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 07:39:06 -0700 (PDT)
X-QQ-mid: bizesmtp72t1658759925tes7hwx1
Received: from smtpclient.apple ( [111.193.9.146])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 25 Jul 2022 22:38:43 +0800 (CST)
X-QQ-SSF: 01400000002000B0V000B00A0000000
X-QQ-FEAT: DQ0OCu3gog1JVD1aMWAG4Hzd0HB957q6ScZb3/kq17UDFTyfwdmQb/6ecqjF8
        eE5OIYywqAy6jzuY4FIO9RM5B1GETLurAPOVmaicr7eAxKNEew43TCCsKF17vEim+KlGrqq
        TeaZwBauxmOkQGu2+lIYIdxZiG6lJiwhMgYvNmkKCbjn4fAPvX7KGAqFtyAluaodXwWAEPi
        sMg5MSAXAGwcpOo1g21x2MeU6IUZun5GbFkFq3muAvTkWg8R9f9iIlSjggT+YzW1bYaPsG8
        j1NsDD1kWdoxotEBrFfUTZakTQaJv7Q1USHOOcbkLbZwEhnx7DQ6ps5BSsvI2u//KJsoT4H
        QF6kVQVltNmGV5X2QjhK31quG5gxNfYaaWU2z2MoZolb8af71hdQWnWSbBvlUEkeTqPPuvL
X-QQ-GoodBg: 2
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH 0/7] USB: cdc: add control and state defines
From:   Yan Xinyu <sdlyyxy@bupt.edu.cn>
In-Reply-To: <20220725075841.1187-1-johan@kernel.org>
Date:   Mon, 25 Jul 2022 22:38:42 +0800
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        Felipe Balbi <balbi@kernel.org>, linux-staging@lists.linux.dev,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <5964CFE8-1B65-4FE2-9154-0F1C079CE916@bupt.edu.cn>
References: <20220725075841.1187-1-johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
X-Mailer: Apple Mail (2.3696.100.31)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:bupt.edu.cn:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jul 25, 2022, at 15:58, Johan Hovold <johan@kernel.org> wrote:
> 
> Several drivers use the control-line and serial-state bitmap values from
> the CDC spec, but there were no matching defines in the global CDC
> (UAPI) header.
> 
> This series adds the missing defines and converts cdc-acm and f_acm to
> use them.
> 
> One staging driver also had an unused set of CDC defines which are
> removed.
> 
> The final patch by Yan Xinyu, which triggered this work, converts the
> usb_wwan driver to use CDC defines instead of hardcoded values in its
> line-control handling.
> 
> Greg, are you ok with me taking these through USB serial (where there
> are a few more drivers that could potentially use them) or do you want
> to take the lot through your tree directly?
> 
> Johan
> 
> 
> Johan Hovold (6):
>  USB: cdc: add control-signal defines
>  USB: cdc: add serial-state defines
>  USB: cdc-acm: use CDC control-line defines
>  USB: cdc-acm: use CDC serial-state defines
>  staging: gdm724x: drop unused CDC defines
>  USB: gadget: f_acm: use CDC defines
> 
> Yan Xinyu (1):
>  USB: serial: usb_wwan: replace DTR/RTS magic numbers with macros
> 
> drivers/staging/gdm724x/gdm_tty.c   |  6 -----
> drivers/usb/class/cdc-acm.c         | 42 ++++++++++++++---------------
> drivers/usb/class/cdc-acm.h         | 20 --------------
> drivers/usb/gadget/function/f_acm.c | 20 ++++----------
> drivers/usb/serial/usb_wwan.c       | 10 ++++---
> include/uapi/linux/usb/cdc.h        | 13 +++++++++
> 6 files changed, 45 insertions(+), 66 deletions(-)
> 
> -- 
> 2.35.1
> 

Thank you so much for spending your time to write this patch series!
And thank you and Greg for your reviews, they are very informative
and educational!

sdlyyxy




Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F1057D8B1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 04:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbiGVClO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 22:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbiGVClM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 22:41:12 -0400
Received: from smtpproxy21.qq.com (smtpbg703.qq.com [203.205.195.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8663C863D2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 19:41:10 -0700 (PDT)
X-QQ-mid: bizesmtp72t1658457653tx66qclh
Received: from smtpclient.apple ( [111.193.9.146])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 22 Jul 2022 10:40:51 +0800 (CST)
X-QQ-SSF: 01400000000000B0V000000A0000000
X-QQ-FEAT: CR3LFp2JE4k+isgZ05f0FwtZrz40qnyFZZqcNWKzCnRiE6iBF1XMOb40OSMmE
        ttwNFQlVisvZ8jxlzsVH+8auBOcoKiAPyRu+1Xkd39V6UrCDZzjECQmSTLPwXAbJvNsLio7
        oiKRudH22ic3cTkC82GYvVbN14gBwKbFGTUd8omrUerj6e8Qg7YpeefFtufFmQLgMQKBa+G
        1/4EEmHy4W8QV5oNb64//mIHvQl4/idH9o2YBJqFv6s3Je1MoN31hpkiTdLOGl+YcRygBxN
        5ErSTBbRyxPMi0OEi899+53K6vItbgkiEbCBdtQpU97s9z4ji4I6pg4iZLWvQSJ0RzWUASr
        nJ63vYit8mznRso6224CzAYHEF5Ix6TisKBZ1ZvIPg9R6nk7IWvy61KaYcNmQ==
X-QQ-GoodBg: 2
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH v2] USB: serial: usb_wwan: replace DTR/RTS magic numbers
 with macros
From:   Yan Xinyu <sdlyyxy@bupt.edu.cn>
In-Reply-To: <YtmYWbRtbNvph6lF@kroah.com>
Date:   Fri, 22 Jul 2022 10:40:51 +0800
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <6C016E08-5348-45EB-98BE-84F4BE3BA417@bupt.edu.cn>
References: <20220721155257.631793-1-sdlyyxy@bupt.edu.cn>
 <YtmYWbRtbNvph6lF@kroah.com>
To:     Greg KH <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3696.100.31)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:bupt.edu.cn:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jul 22, 2022, at 02:18, Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> On Thu, Jul 21, 2022 at 11:52:57PM +0800, Yan Xinyu wrote:
>> The usb_wwan_send_setup function generates DTR/RTS signals in compliance
>> with CDC ACM standard. This patch changes magic numbers in this function
>> to equivalent macros.
>> 
>> Signed-off-by: Yan Xinyu <sdlyyxy@bupt.edu.cn>
>> ---
>> v1->v2:
>> * Fix Signed-off-by name.
>> ---
>> drivers/usb/serial/usb_wwan.c | 13 +++++++++----
>> 1 file changed, 9 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/usb/serial/usb_wwan.c b/drivers/usb/serial/usb_wwan.c
>> index dab38b63eaf7..a6bd6144702d 100644
>> --- a/drivers/usb/serial/usb_wwan.c
>> +++ b/drivers/usb/serial/usb_wwan.c
>> @@ -29,10 +29,14 @@
>> #include <linux/bitops.h>
>> #include <linux/uaccess.h>
>> #include <linux/usb.h>
>> +#include <linux/usb/cdc.h>
>> #include <linux/usb/serial.h>
>> #include <linux/serial.h>
>> #include "usb-wwan.h"
>> 
>> +#define ACM_CTRL_DTR 0x01
>> +#define ACM_CTRL_RTS 0x02
> 
> Why are these not in the cdc.h file already?

These are defined in the drivers/usb/class/cdc-acm.h file. Is it safe
to include it?

Thanks,
sdlyyxy



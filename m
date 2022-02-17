Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215F34B98F6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 07:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbiBQGLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 01:11:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235194AbiBQGLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 01:11:01 -0500
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net (zg8tmty1ljiyny4xntqumjca.icoremail.net [165.227.154.27])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id DF578C7E91;
        Wed, 16 Feb 2022 22:10:42 -0800 (PST)
Received: by ajax-webmail-mail-app2 (Coremail) ; Thu, 17 Feb 2022 14:10:10
 +0800 (GMT+08:00)
X-Originating-IP: [180.169.129.130]
Date:   Thu, 17 Feb 2022 14:10:10 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Jing Leng" <3090101217@zju.edu.cn>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        "Jing Leng" <jleng@ambarella.com>, ruslan.bilovol@gmail.com,
        jbrunet@baylibre.com, pavel.hofman@ivitera.com, pawell@cadence.com,
        jackp@codeaurora.org, balbi@kernel.org, colin.king@intel.com
Subject: [PATCH v3] usb: gadget: f_uac2: fix superspeed transfer
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <20220217055503.8057-1-3090101217@zju.edu.cn>
References: <YgpruynyO1AJr7bn@kroah.com>
 <20220217055503.8057-1-3090101217@zju.edu.cn>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <258cfffe.b20d3.17f064d6977.Coremail.3090101217@zju.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: by_KCgDHzyPC5g1i7rLzAQ--.39975W
X-CM-SenderInfo: qtqziiyqrsilo62m3hxhgxhubq/1tbiAwIEBVNG3FjlrQAFsc
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZyBLSCwKCjEuIE9sZCB2ZXJzaW9uIGtlcm5lbCBjYW4gc3VwcG9ydCBzdXBlcnNwZWVk
IHRyYW5zZmVyLCB0aGUgcHJvYmxlbQp3YXMgaW50cm9kdWNlZCBieSB0aGUgZm9sbG93aW5nIG1v
ZGlmaWNhdGlvbjoKIGNvbW1pdCBlYWY2Y2JlMDk5MjA1MmE0NmQ5MzA0N2RjMTIyZmFkNTEyNmFh
M2JkCiBBdXRob3I6IFJ1c2xhbiBCaWxvdm9sIDxydXNsYW4uYmlsb3ZvbEBnbWFpbC5jb20+CiBE
YXRlOiAgIE1vbiBKdWwgMTIgMTQ6NTU6MjggMjAyMSArMDIwMAogCiAgICAgdXNiOiBnYWRnZXQ6
IGZfdWFjMjogYWRkIHZvbHVtZSBhbmQgbXV0ZSBzdXBwb3J0CgoyLiBPbmx5IHNzX2VwX2ludF9k
ZXNjIGVuZHBvaW50IGRvZXNuJ3QgaGF2ZSAnU3VwZXJTcGVlZCBFbmRwb2ludApDb21wYW5pb24g
RGVzY3JpcHRvcicgZm9sbG93ZWQgKEFsbCBvdGhlciBlbmRwb2ludHMgaGF2ZSBpdCkuCgpTbyBp
dCBpcyBhIGJ1Z2ZpeCByYXRoZXIgdGhhbiBhIGZlYXR1cmUuCgpUaGFua3MsCkppbmcgTGVuZw==


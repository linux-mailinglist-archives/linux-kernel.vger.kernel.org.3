Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075B44C69EF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 12:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiB1LOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 06:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235599AbiB1LLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 06:11:04 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEBF70CE2;
        Mon, 28 Feb 2022 03:09:41 -0800 (PST)
Received: from evilbit.green-communications.fr ([92.154.77.116]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis)
 id 1Mv3M8-1oFN0F40K8-00r03u; Mon, 28 Feb 2022 12:04:20 +0100
From:   Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Testing the thermal genetlink API
Date:   Mon, 28 Feb 2022 12:03:50 +0100
Message-Id: <20220228110351.20518-1-nicolas.cavallari@green-communications.fr>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:289vm7xDMk7TSjp9EJ53roceQIvaOK1Ht1fwI108U7LfRi15fj3
 /VmeRsBsZY0lCaLhVsA0Yc3XFDlui72OYPzGwswK2JWcZlzYSqad/VVJUsE0XwgkOmzgNqY
 yGu8Mc7yxdx7q4+QcwlnLX3VjLXa85gs2O3oxUqSsuYzwwWXtGmhD2ZNRYgMRWjoC0qT0GO
 aL4p4xbyTiwMoKiEt8pZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+dczmfZgk9k=:8Qp+aw4edBZaso/74U09d/
 deqOTtDXqhrCy+6HWUoGR76/R5kYCVbeut64Kf8E31n2MU+Npt6EEqO+lcq19NkxbqPp7HWKl
 Kk/bGYepzpB5xZPyRYCyc3p3lV0czxtFJ1fmk+WsE3xdXc5JR08vNCabwmCbtaK/h1aov9Ldl
 E1HcQVQ0zmexvokmk0HyrQXuxatp3Ln7oG5eHkLE9yMwmk+4iyyl7x9Et1SeKVw5dQbQUvB+J
 Iidk1y0+aj9RwmRcJCtjP07lPVNIUdUxg91SAharWjQ1+I6Ho3JJPyNIqp0d2B9tqVOSRmSDA
 Va73/nV8zig9OwLV9/Q7CvacitYd2xIVkbF/c2Qv0ksR5pfy6aNLvc3hVSTsFiNmAb1DNFjo2
 U1vamzj/mx2XSjVtQ7wFmmefNBB6YYVZOA8VqD3CBGQNsC+AP76Y4MvXMJ3c1KOrKx4VYKWvU
 3sAdYWq8plbVjA/YpobwsDcg1QniFs0n8zBPXW0XKTWP42m70CNqRRFEXibfsLue624WrOMEN
 2d7exTU/yTejBXW23WIVREebSWQPnuq29AasqpXiqEmZsrh/a2xZuGugpWIhO8LbS4mctqkes
 KAQEv9TT5Hs5XLHyJqhnHiqGOnGlP30fNbOL2s658BaTrEbZxMEOvDFtmK61LK/5dAyRKMFU/
 u+u+7ySzupDHkK4YmLGLweoB7h3q39EKZWavy84/ryRt47RP+QOuaS6V1tvNC78ycVUGcBmaV
 pm42KfULfxiCk+u/L2sTnAxDUZ6Au05qc1O77g==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've played a bit with the thermal netlink interface and it wasn't pleasant:

1. The way attributes are used is painful.  Instead of using arrays of
   nested structs-like, it flattens them into a big nested attr where
   you have to guess when an entry starts and when it ends.
   libnl provides no helper for this case:

   [{nla_type=TZ|F_NESTED},
	[{nla_type=TZ_ID}, 1]
	[{nla_type=TZ_NAME}, "name1"]
	[{nla_type=TZ_ID}, 2]
	[{nla_type=TZ_NAME}, "name2"]
	[{nla_type=TZ_ID}, 3]
	[{nla_type=TZ_NAME}, "name3"]
	[{nla_type=TZ_ID}, 4]
	[{nla_type=TZ_NAME}, "name4"]
   ]

2. The genl_cmd types are not unique between multicast events and
   command replies.  If you send genl_cmd=3 (CMD_TZ_GET_TEMP) and you
   get a genl_cmd=3 reply, you cannot know if it is a CMD_TZ_GET_TEMP
   response or a EVENT_TZ_DISABLE because both have genl_cmd=3, but
   completely different semantics.

3. The API is heavy.  Getting the complete information about all thermal
   zones requires 1 + 6 * thermal_zones netlink requests, each of them
   only returning few information.  You need most of them to merely
   translate the event's TZ_ID/TZ_TRIP_ID/CDEV_ID to names.

4. THERMAL_GENL_CMD_TZ_GET_TRIP cause an oops if the thermal zone driver
   does not have a get_trip_hyst callback.
   This concerns all drivers, short of two.  A patch follows.

For the record, I couldn't find any open source program using this API.
It's also not enabled in all distributions.



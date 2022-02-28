Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C404C69F0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 12:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbiB1LOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 06:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235607AbiB1LLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 06:11:04 -0500
X-Greylist: delayed 312 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Feb 2022 03:09:41 PST
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D95E6E8F1;
        Mon, 28 Feb 2022 03:09:40 -0800 (PST)
Received: from evilbit.green-communications.fr ([92.154.77.116]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis)
 id 1MqZE0-1o25Ic3yFs-00mcLC; Mon, 28 Feb 2022 12:04:23 +0100
From:   Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: genetlink: Fix TZ_GET_TRIP NULL pointer dereference
Date:   Mon, 28 Feb 2022 12:03:51 +0100
Message-Id: <20220228110351.20518-2-nicolas.cavallari@green-communications.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220228110351.20518-1-nicolas.cavallari@green-communications.fr>
References: <20220228110351.20518-1-nicolas.cavallari@green-communications.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Z23tdDyKIgIMHnYp/38gWcoqsVjOYU4hm9ReJpXzE/mCJ5x6hUX
 4iYXgS7D7k995wnC7lbYkdxiO6y58eg2A4BYDeBxh/BsztFyOi2L+KGdGz5YY8Z/fthO/WF
 8hLl/FdDWsDTM3QdE2nV6x6aStzK6DuVKs1H1b7JCuyYrMCNSczoHVCeT3t/U1mFuCm7PAY
 VSTkkA+XZPRjJP9AIVg8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wZmt3fsaZFA=:cLOupJGsEzb0sPlifnbInd
 8UsZi9s9FlvobtrUwKhn66i2XKvST2QxIjulNPv+psAnUS7Wu+y7lDVQUFDcC49taSHXNm8ZD
 obJaOCjZfuCeOqlxrDky9F2HP6E25n3/cRofyUVuD69Y8f8CHE0bgoV1wFN8Y3gG7sUiF5Ki7
 ZG7xf7F/8VjsOcjZux+iuAKEJvBAT9tU/0a172kER7xPiDLaqyPr9YF+S2/pkyQ4RVFnkwe6W
 6w5MQJA9pMQW5HR3mFL32be3SX4bdvTXMhv08oVlkg43y+YkboW1zjoCC9/dTcphnp9Q/10QB
 843Tx8aGmPsU8SJxVzvlzjtitQ186WYlKtHkvDL2CGJpkchyGLoGh+Bq+RtGeUhmhjYhy4QLM
 dA2RP7K528SLyBi7orqbTI2NTZ/Ri893WGXBDfnBcElP97aPMnj5OUWCpC8ejMIMVhC8j8eQU
 vCSpnsbBzD3ySiRE0FkhdU1B0GKFW7e4Uem04WlDcjeL/ZmLWybIBbS8yj1QV9kxB5FfPzARf
 IyX4O6JiyCX2eF8fILMsX/3XsL9ZiYEbgOAusemGL2oVqxVk929C6jb2AC/BSJO0+RRFoPnYu
 /W8peUrW7zo0Lhwrn0qqkr7eh1rakXitvdA+gRG72BKpH+NO4YhkEbK2H2ApnhNDoWWoZmU3L
 YhY/gjqiWbRTfqpST581q3WB3eoGeJw87tPXg88RRrVxpr35sRDT4eIjDP3MuCWWUAp2ovDAr
 OBPzulVOjfkdUpxu8TTwJVWM1h7bk+tn1lFcQg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not call get_trip_hyst() if the thermal zone does not define one.

Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
---
 drivers/thermal/thermal_netlink.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_netlink.c
index a16dd4d5d710..73e68cce292e 100644
--- a/drivers/thermal/thermal_netlink.c
+++ b/drivers/thermal/thermal_netlink.c
@@ -419,11 +419,12 @@ static int thermal_genl_cmd_tz_get_trip(struct param *p)
 	for (i = 0; i < tz->trips; i++) {
 
 		enum thermal_trip_type type;
-		int temp, hyst;
+		int temp, hyst = 0;
 
 		tz->ops->get_trip_type(tz, i, &type);
 		tz->ops->get_trip_temp(tz, i, &temp);
-		tz->ops->get_trip_hyst(tz, i, &hyst);
+		if (tz->ops->get_trip_hyst)
+			tz->ops->get_trip_hyst(tz, i, &hyst);
 
 		if (nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_ID, i) ||
 		    nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_TYPE, type) ||
-- 
2.35.1


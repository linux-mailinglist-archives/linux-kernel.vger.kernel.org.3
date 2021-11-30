Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53603462AEA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 04:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237792AbhK3DKc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 29 Nov 2021 22:10:32 -0500
Received: from ms.asus.com ([103.10.4.137]:10091 "EHLO ms.asus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237771AbhK3DKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 22:10:30 -0500
X-Greylist: delayed 591 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Nov 2021 22:10:30 EST
IronPort-Data: =?us-ascii?q?A9a23=3ADG2gk6hg8O+39gkIKbEyRbHjX161lxIKZh0uj?=
 =?us-ascii?q?C45NGQN5FlHY01jehtvXj2GP6qIYzb1eY10bYq28kgP7ZDSy9A1GlBqrH9hE?=
 =?us-ascii?q?C5H+JHPbTi7wuccHM8zwvUu/yuL1u1GAjX9BJtcokH0907F3ofJ/SEUOZGgH?=
 =?us-ascii?q?tIQOcacUsxDbVYMpBQJ1XqPr9UEbrtA2rBVNe8tVeTa+KUzMHf9s9J93/l9B?=
 =?us-ascii?q?6ir8HuDt9yq0N8UU8BXWBxFgLPevyF94JM3GZn0AkvCb619L6uEH7uFx7aj5?=
 =?us-ascii?q?mXU41EkEc6++lr5WhRVGPiIZ07S1DwPAcBOgTAbzsA2+p0nOeQRb3Bsmiihl?=
 =?us-ascii?q?sts05NGspnYpQIBYPSRxL9EDkIw/yZWePcuFKX8CXiysM+QzgvFaXzjzu9zF?=
 =?us-ascii?q?2kyPIsF6qB2B31D8boTLzVlRh+Ziu21wJq/S+9xlsokMc/nNZ8evXcmyivWZ?=
 =?us-ascii?q?d4iQJbeU+DX/tVwwjg9nIZNEOzYas5fbiBgBDzEYhtSKhIUBYg4keOAmHbya?=
 =?us-ascii?q?XtbpUiTqK5x5HLcpDGdepCF3MH9ZsTPSNVPk0KRtyfYpzm/CRYALNqS1XyM6?=
 =?us-ascii?q?W+37tIjVBjTAOo6fIBUPNYz6LFL+lEuNQ=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AGV801KlwiUU+ZpP6eu/bZ+06YY7pDfL+3D?=
 =?us-ascii?q?Abv31ZSRFFG/Fxl6iV88jzsiWE9wr5OUtQ/exoV5PgfZqxz/NICOoqTNKftW?=
 =?us-ascii?q?vd2FdARbsKheCJ/9SJIVydygc378ldmsZFZOEYdWIK7voTKmGDYrEdKBruyt?=
 =?us-ascii?q?HPuQ+lpU0dNT2DMMtbnnxE4kLxKDwLeOGCbaBJbaZ1IqJ81kCdkbN+VLXHOk?=
 =?us-ascii?q?U4?=
Received: from tp-exrelay-v05.corpnet.asus ([172.22.46.12])
  by ms.asus.com with ESMTP; 30 Nov 2021 10:57:18 +0800
Received: from TP-EXRELAY-V04.corpnet.asus (172.22.46.11) by
 TP-EXRELAY-V05.corpnet.asus (172.22.46.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.12; Tue, 30 Nov 2021 10:57:16 +0800
Received: from localhost.localdomain (10.96.194.52) by relay-b-4.corpnet.asus
 (172.22.46.11) with Microsoft SMTP Server id 15.1.2375.12 via Frontend
 Transport; Tue, 30 Nov 2021 10:57:16 +0800
From:   steven_syu <steven_syu@asus.com>
To:     <heikki.krogerus@linux.intel.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, steven_syu <steven_syu@asus.com>
Subject: [PATCH] usb: typec: clear usb_pd flag if change to typec only mode
Date:   Tue, 30 Nov 2021 10:57:13 +0800
Message-ID: <1638241033-12467-1-git-send-email-steven_syu@asus.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3092-8.6.1018-26560.003
X-TM-AS-Result: No-10--2.543100-8.000000
X-TMASE-MatchedRID: H1uufQ/utJ2plamT4YpFUziEPRj9j9rvjkDrBOJwwnQ8JmmJxjOaQWau
        eaCWU0mFFsQa0121ATznYcKpCyR3r/SCkSozt+9hs0T0PE+KHuVLXPA26IG0hN9RlPzeVuQQ3oD
        iQ/KYKA+VvBTFZs24fqhF+bM402w/wG9P01lFxWXi8zVgXoAltmHJPdY2OmlS0C1sQRfQzEHEQd
        G7H66TyN+E/XGDLHcMh+RcDitieSk66yoqrWqZqZzKE0iYJtrmOT0Agn0gw7A021j1TfzKxbJRR
        tHp921bW6Tn4jImS9DWafYZw19sP9i98zDhIsyyjofsMjQaxVwyYjbiqIQ3CsykhtyXcigD6rVd
        gBjDT2oh1j2M6LiVMg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.543100-8.000000
X-TMASE-Version: SMEX-14.0.0.3092-8.6.1018-26560.003
X-TM-SNTS-SMTP: 41C6793E4F0DB73FBC17895E78C6C14411B14091E01BC78B0C3FDA5F876031C82000:9
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch handle power mode change from PD to Type-C only
and the user space unknown power delivery  was turned off
by typec driver.

Signed-off-by: steven_syu <steven_syu@asus.com>
---
 drivers/usb/typec/class.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index aeef453..11e2a98 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -1718,6 +1718,10 @@ void typec_set_pwr_opmode(struct typec_port *port,
                        partner->usb_pd = 1;
                        sysfs_notify(&partner_dev->kobj, NULL,
                                     "supports_usb_power_delivery");
+               } else if (opmode != TYPEC_PWR_MODE_PD && partner->usb_pd) {
+                       partner->usb_pd = 0;
+                       sysfs_notify(&partner_dev->kobj, NULL,
+                                    "supports_usb_power_delivery");
                }
                put_device(partner_dev);
        }
--
2.7.4

===================================================================================================================================
¾÷±K¸ê°T This email and any attachments to it contain confidential information and are intended solely for the use of the individual to whom it is addressed.If you are not the intended recipient or receive it accidentally, please immediately notify the sender by e-mail and delete the message and any attachments from your computer system, and destroy all hard copies. If any, please be advised that any unauthorized disclosure, copying, distribution or any action taken or omitted in reliance on this, is illegal and prohibited. Furthermore, any views or opinions expressed are solely those of the author and do not represent those of ASUSTeK. Thank you for your cooperation.
===================================================================================================================================

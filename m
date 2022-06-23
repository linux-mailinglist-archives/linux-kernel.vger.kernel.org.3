Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B387C557766
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbiFWKGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiFWKGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:06:13 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2019.outbound.protection.outlook.com [40.92.89.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946A449F07
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 03:06:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvHNc5JTJkZeYZy8ygCL5IrzrLxb/0wRMQ21D5agT3Yho2y0jRtB1KvcKAU3a0B7b4iqA8vT9umHPhpN2qJcWtqteFyMpj7hjjXW7bSDIAKbYOJH1mT3hhSwt377kiAFIRUjXVPyXu+fEQ1KAx0hqFUZioHxz0QK+FghCwkQX9IHAl0ersliw0IqBqwDHRsz8jbecp7zmTJ+8IXsZG03b/ZVyGPgJkoyNNx5vuh1/Nlm3/EIDUG+9OEDglWuIcOnrwv/IDh0HuBiQ1L3WU0c6RfSw8lFy1L1VxB1QZS/U1lkqdYJP5KUl70Og2EU75MBw1UhRRH1rv9D2fEnJhMXvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzKwUPPwRsT8aFCwmg3dhf6ejMVeAjjL62OmP2YB0Pg=;
 b=YeyweDoltIpGyjkJ+iJCi5YGAtX8udEhGcEpsQwfV/lLiwWfBRGRgJdktBX2Csbyj5yjQOdljD6niZW+1YDGjj5QNEWZDU8xbvNf1dxQ5G2BjTfiziOyEoaBElkDkZwLwntT281wjR72M276jt7wG0ZR7Dj0quZgUB8EARQKpy/OySiL96+djBwg++Dqww+IkMXtpsdzU1Th1UEA1B/d9tt2sSOaK13nl7BWIt6URdhivfDgI5qVNP96CSGR+JI2SexKb5uEmd0bOWUwxckVwpiT7e/xEkzVdFGUhl3Pf2lP7V5bUyvdx4h7EJNasBvRhX+TvhwkhsOfUC+bGJygNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzKwUPPwRsT8aFCwmg3dhf6ejMVeAjjL62OmP2YB0Pg=;
 b=uTAUnjvQz+HbCRTG+h6wjYwPvGeJvEuwREiB4hVz3A83XjhZ601iK54Fur3NKLL48lDl7UlXj8KW5Y3WQAN3afHKXSFuzwUf9QiceT7OQmsZ0nBAnRl3IZc5UNvlYmoPetaYy9lARASTjWpPHTwijGwbe+exV0mY7uIqPJTjS/G9EmIezPWBenPDZd9oNY20iq78vqerSBUCYQO//3wlPgJycoYVzNWZ6P01BfUX9dxcfixMD7GwPIbOhYMsvSaiRSmyzNOKM7aWUm8KcRJYUWIEm9UMS9LKXUR2j9TSYbRSLNlMJ9KI9NHxqD8/i86pIhjG0GpCvfuJTBlbD5iPrw==
Received: from AM9P190MB1299.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:267::9)
 by VE1P190MB0879.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:1ab::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Thu, 23 Jun
 2022 10:06:09 +0000
Received: from AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 ([fe80::c0f4:a98e:332a:2397]) by AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 ([fe80::c0f4:a98e:332a:2397%5]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 10:06:09 +0000
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Felix Schlepper <f3sch.git@outlook.com>
Subject: [PATCH v4 3/3] Staging: rtl8192e: Cleaning up error handling
Date:   Thu, 23 Jun 2022 12:05:57 +0200
Message-ID: <AM9P190MB1299445E2FA63C87608E6CC7A5B59@AM9P190MB1299.EURP190.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1655975970.git.f3sch.git@outlook.com>
References: <cover.1655975970.git.f3sch.git@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [Oll5dDN9NavCiWA9heI08KKX2XMkeQ8l]
X-ClientProxiedBy: AM5PR0602CA0001.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::11) To AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:267::9)
X-Microsoft-Original-Message-ID: <13b32131cd00a1f0b8793657a24ada71240a8350.1655975970.git.f3sch.git@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe7c359a-e676-40b3-84ba-08da54fffecd
X-MS-Exchange-SLBlob-MailProps: EpEO96k6WokJw9qhnqKg7+E0MqObEIk6YFAzE+fssm8VyXUMoTZexZEO34hAXaBHrd39nltYwiR9tdX0zzgQY7bBeMpdWKvrg799CBlN7Sh3ig0g3VGQow83+nyS5nmf6aRz2QZlyFKSi9HcJp/aCu7jkrFl1oo3zL4WeN8Q4NftgXri0Cr34Qzzv+J6LxgwZVZaG03qZ/8zUH1ElrBc3Q+f6Rpb7Go0lPd4Ba94hfY7Zra5GEkEOzJp3tuakn7IXt7lsCJ9/pP2MSFU6MiigOptdaxTocjBeSQzIgSoRME/zOcSOyMTeLvciXmaYHxhFMEvWjGqhdG2/57X9M4cD3/h/NouW2XD+nqdoc+3XESW8oIq/NxnPNyPIJ8IfF0fCspnqyyLoIDnz1VkjFHsAivAuteJQozlveNWbIrvTRO7l5r+dFj7NWISVTDOkd8sKYcAyHBPlXdMX/4oNGEg4/cbXI7tWF6r61G5rlSw/TLWW8tXRxlJlVtP/QHJC8i266aSixjVXZE6XL03PmI1UB3LWhwAIJG9jhALFBsI5ljFVO4JDtNCEfsMIiZlJiYLFfXPSKQXezQeTNd/l1ZH3ITBGvi2akVREHN5su9HHyLA5pp3T7dDE3SQmuwxbSxCvTfyjS3/ZvCRy1VevgFyhyza1zioBkjzK/FnmrwzJIRKgfinnB79ajPtjaCk6AcaGxUnPK9CZF0rpGzlFe3yhV6YGjmfNrpws8jE56C4ItZTY398wMy6sj77zurniZskZfeDQPNO5UY=
X-MS-TrafficTypeDiagnostic: VE1P190MB0879:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z+IoFAYY1JpD2SCN7egznG38Y2S2deLnu+phtEQwVBEdk15wzLt+Tob2/x1WjSRK9toemvduPTcDtdBQQBGuJcP7iRJ3u2oESPKCvEQ5bNx7Ig8zjGzgdkJGlEd/OKR7ercMqmEsD77a6yW9aOjDQ4FEfuQ5Y09WJVU7c3NjmYYJFXqathuMoH3TNN7cjbbQFJ93ozxCd/yhlLl9JSnRjEKpWwn7IC52MdPq6vfgeMQ5NUY0ryHcYDv5YYnbr7ChpELTVFadXNGQ/GLSGaa9jpT5uIv1Y8btkREpuXQfpg1Tdkj6gaEfNPKlnac1GRKjwHx5t7f79BVSnuHRsEmMUfOpfLIFBhqPKbfJQrj5D5cyMajoYkuPlxerjVAZhj0HU6MH2SAJh7Tt5rNe5NzYK/D/Zd6CJLnvE2vdvooYn3q4EUMjSSq97iiSONLviaszyzSFAJm+cltT9MAxWvsZflSLcoq81OG8i/e+3IO5lzRDb4rD39DTHn53M5YOWVA30y5frJz/sSBJxrD/FMgTQwhzoLkQYxz7Qk4beyCWMSSUN/Kl4THvA6ZlTev9BnojUDuRLIp6NS2R3xtZwwKbfl8JZgY47WlOLw3DYlkJrXyucuuV99BYBUrA2pUMuHgCF2CeFLZ27kughsUBvlHvlg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ALi91tNgaC44wobwUtwdaHIUC9Zi8uah8IuJSJIeT3FAYkl9US9LvlW5owhk?=
 =?us-ascii?Q?jkVLK2GhWpFYaVEUROreui/7vkYG/TNxtUO0Z2lMHThvyP2jR57H5sGMRKI8?=
 =?us-ascii?Q?qKLYBhYQq0PtB+M3Dxj/kYIJDzM8NBYBLGL+S5LdEMWNFXAnt0nHNKTAz9fw?=
 =?us-ascii?Q?Q4gopNMn0DlBok3aotdfyKd7Wex6JWyauyF8atBEzyygxXYjbLd9NwAHkhNS?=
 =?us-ascii?Q?iSZGA5WZZPQTOF2Q1PpuSAeCkoUQcY6bI0K1voE1vNzs64EIDmurKlqxvbeu?=
 =?us-ascii?Q?jzn75j99kMi6Lj3maJK3HcuirvQPdKMDhuWancnfnNatyGmWONRfWwdJNazr?=
 =?us-ascii?Q?N3egBW4UPqtuUzGnIxZHBqiCYtQd/mwWo1jZSpKc++Scwc7ffCYq/CsLZkqR?=
 =?us-ascii?Q?7VueuXxs3qZBXfMiEPVu55BQeFlJHlZofCEAH+1F4huufSAEwcThrs4F4ZpA?=
 =?us-ascii?Q?9hJBLsgBjHyPta1mJDQlTSytS3+XERAD1koOHRi4o1GUWUFOFc/J+F4Fcm15?=
 =?us-ascii?Q?8DetFmBna4fV559gtysqPqV2TxdiAIDEeLTCtsh2AbAGFPuVBPT7xv4BeLAg?=
 =?us-ascii?Q?qVLlTvt2vI6cRHgoNEibCd2voaOqGNdIUO5vdFqi5frqPh6/KH8nxT6QyqYR?=
 =?us-ascii?Q?RTwg9T7FFYj6ol2XFWGZDHIvDJGeN/KinASYE1Io5syPPb8LXGMHeJZ8j49j?=
 =?us-ascii?Q?8z5ujiOEycy3q0evpBMO7Ed9w+L91WkFxePu0TurM0IYO3AusKKHSCbjPzAb?=
 =?us-ascii?Q?ush99r0Kc5H5JCNEGktmtWO682k50mKkIJyngfF6k6n9UY7zjhzRfEx1ypKy?=
 =?us-ascii?Q?zV84e5gOUsP0zjP/Ygu98N/1PrxwG3Jo8AfTzNiM1Kb84U6d6vcuR3FLY3wd?=
 =?us-ascii?Q?6YbknUoMCFNYKuNZJKf1FpPDqyVQsanqorNeXeak9qbh2fg9t/Ks12DkixTi?=
 =?us-ascii?Q?lVk3oDYmkspB+ZoADYammA64Cskgv6hiFlQxXYrgPNhDRUd1gOhQHNNhbwcw?=
 =?us-ascii?Q?BlTgSCrS+4UMzI1nzT0PG90lZG5t+1n3yqzmL4H484MfuK4i+t3kOty8gImY?=
 =?us-ascii?Q?q4Q6dPrmxVjy6Syb+84VaDRh5b1u9uWVN61owPfSvSQp3atcnqQbKSyF8ijA?=
 =?us-ascii?Q?tQkciSA101U7SMxOcA/YegW0dE34KKeizXlea9T8ySl+unrAuf1CVDI4Eyzx?=
 =?us-ascii?Q?V0DuyxfOyD/7BbREhngESOEyEFXSkVe4TZgiyLwloQ/ne/opHmcepPLBbix9?=
 =?us-ascii?Q?j6Tf8aqh0rV9v96d51Fmiihia/R5ZKdy2S8WQYnJCQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe7c359a-e676-40b3-84ba-08da54fffecd
X-MS-Exchange-CrossTenant-AuthSource: AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 10:06:09.5871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P190MB0879
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moved error handling to one common block.
This removes double checking if all txb->fragments[]
were initialized.
The original code worked fine, but this is cleaner.

Signed-off-by: Felix Schlepper <f3sch.git@outlook.com>
---
 drivers/staging/rtl8192e/rtllib_tx.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 1307cf55741a..42f81b23a144 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -214,19 +214,19 @@ static struct rtllib_txb *rtllib_alloc_txb(int nr_frags, int txb_size,
 
 	for (i = 0; i < nr_frags; i++) {
 		txb->fragments[i] = dev_alloc_skb(txb_size);
-		if (unlikely(!txb->fragments[i])) {
-			i--;
-			break;
-		}
+		if (unlikely(!txb->fragments[i]))
+			goto err_free;
 		memset(txb->fragments[i]->cb, 0, sizeof(txb->fragments[i]->cb));
 	}
-	if (unlikely(i != nr_frags)) {
-		while (i >= 0)
-			dev_kfree_skb_any(txb->fragments[i--]);
-		kfree(txb);
-		return NULL;
-	}
+
 	return txb;
+
+err_free:
+	while (--i >= 0)
+		dev_kfree_skb_any(txb->fragments[i]);
+	kfree(txb);
+
+	return NULL;
 }
 
 static int rtllib_classify(struct sk_buff *skb, u8 bIsAmsdu)
-- 
2.36.1


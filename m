Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CD650ADA1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 04:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443289AbiDVCOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 22:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443287AbiDVCON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 22:14:13 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2111.outbound.protection.outlook.com [40.107.117.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BEF4B1C9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 19:11:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEIS5ws9r4GHFTBLYoFwnxGOfO8QB7Lxm2LZxnVWT1sp4P5APtvAShsl5wfrowyJQCLJN03BGEA29tnopqxSQ4Es9eDtP6Vbm6o8QgSnlXqPneJSIwdQCQhPzrnqBHMeeh92ZcC6MpC8cC5K6AoLIAz7zTwqSHQP6ljOZET27T5QZ373NHONlUw1yoO/UK4KmCM67ROb8Mg9eEo53R1jkxSvdI4z46ty4g1uNWQc60LQH2Hkm5ZsVNYG3/xm6NV2sKBuPWEX0ZZSpbpDcg6yyy4x32ibJg8Q1cZS1ECDIr9LWn0uGfmSWZWhlH6TeApQz9wWkytDmLqrYvjexrXB/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9AZ+N2aCBaDy9TFnA1oYsx4ZWSO6l6r55QfCLqLS3Zw=;
 b=XHrEcGsRjdZ3wwdBkCWPxe9V9lJDGR8TGwefjfiryEAkxJolbf9FoceeokcgnVg9rPPiCHfqHdt2dVVI+SuGlA464xCO7XnftfFN0+BLVcTSfKbnLoFxe+FlOpXutlhtdJES5rzZ6NNLrDAZfQkxLluHL83zdUbUjVudfdmNH2Gm62IAmtrX1W8XJootv79SPmTW/r+PvtFIiImTkww4nH9WMACMMN/j3rd64TKUeLQpc+2MircSPrmCF52hU2voyzFmn8VMiETZjjpv65qNiV5YpWtO6E/ACO82V7uS/lNk64twScsvgMOaltT4yZHkrFfA+iq9MA25LaXd3lOmWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AZ+N2aCBaDy9TFnA1oYsx4ZWSO6l6r55QfCLqLS3Zw=;
 b=psfCm0HvRVRQvdWt6+bDHPcGTFcpOzfQyj1xgUTPApOpxagDTKbeiOupur69vZzrmAX8HQgAqRkkXsfqoNn3UZsuDDR/9/Ew5tcD0ZGBTmKgKPQ4NFIpekNj0siEtXJITp+pchr97208j7IAj9fhMgKuirpVX+sM5C4Asqz5ZD8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 TYAPR06MB2320.apcprd06.prod.outlook.com (2603:1096:404:1f::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Fri, 22 Apr 2022 02:11:16 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c%7]) with mapi id 15.20.5164.025; Fri, 22 Apr 2022
 02:11:16 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] staging: r8188eu: Remove unneeded variable ret in rtw_suspend()
Date:   Fri, 22 Apr 2022 10:10:38 +0800
Message-Id: <20220422021046.121870-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0017.apcprd04.prod.outlook.com
 (2603:1096:202:2::27) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd25443a-0295-44c4-fd51-08da240561b6
X-MS-TrafficTypeDiagnostic: TYAPR06MB2320:EE_
X-Microsoft-Antispam-PRVS: <TYAPR06MB23209ACFA047745DAEF594BAABF79@TYAPR06MB2320.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iMowKBESCcCZZHKuGtkbjxIi0aYwapJYLt11LKNqieMoi5UCIfg1i8xtwulai8E/QvwhoIiE2QNMYd6gORHmuewzNA5qQxo3YcguZ2S3yfzaxjVdChGArufGDUbQQYY0YIZd674UPpU7OmSdagfzdRWtwqxbOkJkXaDic5ahr+2uTRRFmVF36AL85VW18m4LK6jSHFD/xyoyDLCDMJtOGdvtWeHHDsU9LRl6f/FT/6dkfcyZ+7cU6L67vbKi9joaMrzmhN2VuRG6G/UBwfy/FXvUnPQLi5or8ItMgCQA8u9OrviFHQlFfKC0TmyTiEkajXM2nTwFPUSmQdcjvkstDEt8OzqnESEXDJWs7wHuvtzGqhbDhW+DBB1quUAVVMDg09ENMixh6cLC86wD3FPuDBOV6FHvNRmhy16nq4OkZgQUX3xVATfLigmaZ/bW7GI/fg4sL6aw4zBmNptuEXbtFn9FidDZaJFl/RTgQ4bogUVRSZ3c6uxF0y2MVQsCbj4WEFlYBXoHKexNl4y4CMutsluDom1nM/QhQi5cDwnyr7f/+y5HeGrL9BIwAJ8FpBdBfUJvJbWKICvpx27FaWuXwLODBziMX04mxH59nWCyzvW9Ss8A7DGktwHU18fv33o3lUzdvteRAO4t8DTbT6O3ZbHBUZsm+GA4VUv7ux+XF5jr8O/8cr7wqjGpTxQVwaLtkBvki/ytjWyKWbb3YCvKag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(38100700002)(8936002)(508600001)(6486002)(8676002)(6666004)(36756003)(66476007)(66556008)(110136005)(316002)(66946007)(86362001)(83380400001)(4326008)(52116002)(6512007)(6506007)(26005)(1076003)(107886003)(2616005)(186003)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5wZPXdUkrA+Xz2sUTOKB5gLzL/VmN4uIbobmC3NHZUWQoyxNo5AaQ4VFGGJw?=
 =?us-ascii?Q?ED/F3JTaPOF4m7A5lwbBZd2OWfQqsf9fgzTZb6MCUGrqi8l0Ij9ZAoyRoDRm?=
 =?us-ascii?Q?JHUMe3lBAQVwdh8rwbKw15v8krrlnY0aO+DJzJEeewQV43LHZni3Qt6jj1Gb?=
 =?us-ascii?Q?0p+C4tLGp8Lwi/p2LbAXt6Dv9SaVzAIa3BH9A2HkeHSxyhX/+J59DUtmdC7m?=
 =?us-ascii?Q?CBPBVT0PLP7XweFt5G3cU8GU9BOr+X8P216r9Yn6jjO8USd96zLhvnL0YpxJ?=
 =?us-ascii?Q?oGDAvywZl2YVoFKLwJ41WM56NRvJshCL9jJv+1G5bICtS+lJmr46VSKK6pmA?=
 =?us-ascii?Q?/S3EeGKttZEZo9Qh/msRoXCtorilsTvPzOfHGNblT6bUQ4QdG0jMo+CCB4m8?=
 =?us-ascii?Q?uKML82MmeVkgzV6du3sgk+n5lub8ozAdh9lPqHAsd1fIqas4oDvtUC+r2vt6?=
 =?us-ascii?Q?AX1AhSV2HP3S940f4Q/6JfEaxmvk/MT6/7B6qE0KWlw83a5EMS7zQfL1phJ8?=
 =?us-ascii?Q?Pw94txpwDAA1ID5VcNeu5WWZIcs+RYlOL0pvZIBNr3ZwUAXpkK8MLhITmXMH?=
 =?us-ascii?Q?al2cr/8NkcmPqQigm8IcotqciaWJUwVeCte0CgGaBHxtRcWfIQ79vakeRTru?=
 =?us-ascii?Q?d7xsfEl2vBCCdaE5+Y3x09p4TmiXaDk5VzGtFskMUHETpfXS/fOoaXKB/vUN?=
 =?us-ascii?Q?OrJp8fFEjw1kjiRDe0KQfEVXJcBiVnmpJRtvyJYlEAF+4rOPPW0yfQzq0ymu?=
 =?us-ascii?Q?APL0rn6QEbmeLlR6F0OE3S3htszyBjhwULEoyM/wAlTh00+Qau66k53NRHd8?=
 =?us-ascii?Q?VqpOEDc2Zu14TwNhcNzhWBzooUO6zhsasucPBJVmvTaCMTiUyMJT7KqRnF2o?=
 =?us-ascii?Q?yuOj6I2lCucGanPpAjl6Y76cWESVjdVEskjLcHEkDPN7oHuyB2CoernFr3M1?=
 =?us-ascii?Q?NXIbPkJnF5be8pb1x4L7Q9+aqge5yDiaa61GDqlBQH2WDvzCsZm7xI/rqx2S?=
 =?us-ascii?Q?oS+1J5c9C0j+POdB2PtoD8X9O3GOAP8xqe9497ioT9sGbOqFqAMJ8GjgjykO?=
 =?us-ascii?Q?ki5XXZrqJZ48zCVm5CoL25VwJHprPronrnbobQSWRdUFlD4HYQ5AaHAM/XFf?=
 =?us-ascii?Q?7SbWU/pnjUf/BiGGV2lt1OVniGfC9Z9F9K2c/ycOr2oJGFIQG/lHQgPrwQ70?=
 =?us-ascii?Q?7Fu6aTBm/wpzPLRQzlTgVTEl4D1iMedQxs+huuPEbkWSqTDQAuwg7shkpYD+?=
 =?us-ascii?Q?mDnH9IdI/S6nz4iwHMFaI2vSp+H/zVe+XqzOD+GDnP3ZkRkf+pkbIchDEcED?=
 =?us-ascii?Q?HwCfy1Q2bA4UrvV1wWmIxlrV0rZrtsroYrexcB0yHc3psbz4wQDQymWfd7lD?=
 =?us-ascii?Q?1knpXhqpz7oGEysL3QPZINhvMPOEpIUM0QOCvUSAyTbrYU+u9qmLFBLJNkN5?=
 =?us-ascii?Q?s2BRetFIkhDzKi/FDC+okOCcZ2UtzFkud5ZQAuIfJVLRozD1UWc1vRTC9uDL?=
 =?us-ascii?Q?TszK6a8PtDIKflMvJimgyaryk2UjqBKlZ27o6vLGZdlnbhfp0lqvZ6/kjrZB?=
 =?us-ascii?Q?Dims3hK8tnUS2FLouWoMDb76C4mJYFxbPeBBdMIusp1pQFLcbm3wC26UQ9J/?=
 =?us-ascii?Q?g88SUflyy3+0HazrEBIsys1m1MvMBFuWTSEncI9HmeooL1FoHv0KzMjHSFLW?=
 =?us-ascii?Q?+BtDqvjzUGvWdrSmvM2jUpB6BofEG8yjCTtRTnwcfXYAwRtrBj6Ge/YNVkEb?=
 =?us-ascii?Q?Aq8k5gnKbQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd25443a-0295-44c4-fd51-08da240561b6
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 02:11:16.1508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n0o4zoLHit9NP0i+EyuT7jj20R9IZQFYZUyCVjhVF39wNdc1ypEQXBw9UMmAZ1EXQv55asn3St8MmRtY32qqog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR06MB2320
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck error:
drivers/staging/r8188eu/os_dep/usb_intf.c:202:5-8: Unneeded variable: "ret". Return "0" on line 242

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/staging/r8188eu/os_dep/usb_intf.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index 7bd5ab7e5248..68869c5daeff 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -199,8 +199,6 @@ static int rtw_suspend(struct usb_interface *pusb_intf, pm_message_t message)
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
 
-	int ret = 0;
-
 	if ((!padapter->bup) || (padapter->bDriverStopped) ||
 	    (padapter->bSurpriseRemoved))
 		goto exit;
@@ -239,7 +237,7 @@ static int rtw_suspend(struct usb_interface *pusb_intf, pm_message_t message)
 		rtw_indicate_disconnect(padapter);
 
 exit:
-		return ret;
+		return 0;
 }
 
 static int rtw_resume(struct usb_interface *pusb_intf)
-- 
2.35.1


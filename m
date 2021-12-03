Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F554672FC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 08:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379052AbhLCICP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 03:02:15 -0500
Received: from mail-sgaapc01on2134.outbound.protection.outlook.com ([40.107.215.134]:28608
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350800AbhLCICN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 03:02:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jpCdrOG9kagxpr//YV+41q8fmjnrNCz4a/2FkEWBaPLAzs+NA3+LxmGIy2u2Ji9QqLCuJAMMQW8YgMuiASsdjjJ9kf00jwxaiEDksFj6V3cpe2t1mdlAPLOwO5nC5tFtnpJLAfcvEvBMxKUr/51ZfVTTza7X401glWIz6cR99myw4fOdoKGYHZQJZn0OuohyO5oabbzZWQXI+qdsd08AFGKEJgCprwbMofDtErrOFNToLMcqUZ9dg3YgvboHuVqLKm/FwE9kpl6zm20GH+y+kl+eX2sHG4KLE9d4wFGB2pmDn3b9nJTMPzXCTknf3BrbVhVzbt26qf/Tjmz86o0D5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKo+Zqwe7OVlhaPJFUOo017opDIl8mbQepDZobp/WCY=;
 b=M4PtYTC+IFybiDork4vRjpqhqgoXLS7UlrZHlupDWxNSanQhuNhpXLP3c518/MIIXNkeSR/nvfBgyK7R6vQj4z7kqavwUbArqYU8YVfZZj8GzpmdQD6gHNAxHeYGWVoHtKc3mtzMJdJIuM1o0WEaTnYf+LzS9MLAtZfdDanEid+e9GS5mpnvY4c0vzM1ThytQipe2y6ANjHOj8PtKsjWnsA6cbOh1lGV9oXa+qiTFWyhLeX5mzaQ/lE6NwuJMPj1cSRvaV7NV2h4G178nBO0MnBWELg2lDt2gIAm071AuBLKXeroQzdRB+46fFANDCub0cYdDVNY/rtpOHm5TJ3VUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKo+Zqwe7OVlhaPJFUOo017opDIl8mbQepDZobp/WCY=;
 b=J9cVJn/dTCtmxuvKCpud2XP/3XNnus8x34wYu0Je8kGpGBXxJGnbzEdzbhnwyuBlFdKCinq64yXdPF9Z+hq94+UgnIlCv95oel+h1BOX202bPtxOSmtjL/78Wf8eM+dB43VMJdE9jvRq1BbqndFGk3pNB64oKtiQxKkSB6gPpS0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by TY2PR06MB2462.apcprd06.prod.outlook.com (2603:1096:404:4d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Fri, 3 Dec
 2021 07:58:46 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::6093:831:2123:6092]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::6093:831:2123:6092%5]) with mapi id 15.20.4734.027; Fri, 3 Dec 2021
 07:58:46 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, Yihao Han <hanyihao@vivo.com>
Subject: [PATCH] scsi: bfa: Replace snprintf in show functions with sysfs_emit
Date:   Thu,  2 Dec 2021 23:58:33 -0800
Message-Id: <20211203075833.4435-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0185.apcprd02.prod.outlook.com
 (2603:1096:201:21::21) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
Received: from ubuntu.vivo.xyz (103.220.76.181) by HK2PR02CA0185.apcprd02.prod.outlook.com (2603:1096:201:21::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Fri, 3 Dec 2021 07:58:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1d6eedc-ea86-4f5b-029f-08d9b632bb9b
X-MS-TrafficTypeDiagnostic: TY2PR06MB2462:
X-Microsoft-Antispam-PRVS: <TY2PR06MB24620D4D21E16B3274086F23A26A9@TY2PR06MB2462.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:111;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +PfgzXa+uUb+/xys56GQbz7qju5mOPUFV9bPU3eaNbFpZ0W/2EtHrz5w/KTtZiaHWRbOb4JowVuXfYSD5u+TP65+L9vP7WpNxjC1LGYmb9Q4Rg0wOi9ISi8z5rciDlNPHVCEBFBYY1o0GHg9UxROGieJyVMOJ1rmGOCNw/Fk6Jxyuf1GmPpMj/0+3aNGhpXGoTrm0FCzLTNy/4nIv74Q06nluhd3UKmfJ/VDSUTcm89WuB5OLOF6xMyipc0OJBzFVdIEh8J2D3gI8QaZNSAJ9j4x/TKIYjgQTqcOVghEFdvOhER0Nzk9LmRPv3CYUuPa426mPw/GfDKxG0Ic3jeUfgQwXIHZ3Mf82BhFI3u01Kbo9WUXLYZX7miDEUd8EsXvHyj54WNcbczvO++ZHb+wR7qML1bWPor2jlXFt8teI3KZA49Ix75BW5lcy+YMgw+cpPQuYCpD0eQTdHE6H1Z5KUQmJAj+3uQToxDAfOT8pn38CEZFT+Y/HtNxyAb/U3e3U4r8/ipLvPzSOFy37rk5hf1c6JFXIB3toeKhex6vumAPp88c7Y0FbwD7YiPSERmfJXrCoAXH1/HmNViaHlKvNorWHQ48cUELTSI52uHvfeZlbkktW0UbeljI3LWchVfZ3UPwC1dGnEnoxn6I6p8+Q9RZKeYhIanEUv6VdmI8OfQwlHsJ5vcu7GhMRtgpSBUv0laXaCHBtB0er4gm9mbDOKTXDit6FwA7X+a4NzfcA78=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(8676002)(956004)(107886003)(2616005)(26005)(36756003)(6512007)(66476007)(110136005)(508600001)(83380400001)(66556008)(66946007)(1076003)(52116002)(4326008)(38100700002)(6486002)(5660300002)(6506007)(86362001)(38350700002)(8936002)(2906002)(6666004)(316002)(182500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OhhXzx/ntGIwLjcvy3P5Kg6t7ZL7R79n9i+iC11qaj9kwKF0ZKWBosmxiiZ+?=
 =?us-ascii?Q?plWgwPb4Ks1Yw5OpXY0ezKRHM8IjAe/z3eR97uLCcyo70wPdKgQX+X09aEXt?=
 =?us-ascii?Q?hZG0ZifCZByb1Ycs5q/H9R7DKgZS9LsJaGZmRqx1ORif6GLORiNcqt12n99z?=
 =?us-ascii?Q?5+HnkVjjiBJqSb6t0MFUBXxApt9CTNfAwuwGh984noKekny17lDfdHKQvVQA?=
 =?us-ascii?Q?pdvIFNswSs5K7qHy8npvXTe7o+PPtaxQnJKHx1NIEVNyvm2nn3yiQnf5Fw25?=
 =?us-ascii?Q?cdUJN3Sh81jqqD03TZybW5ZGhrFz6TQ3B17pZQXU9oQw9dNQy/W/RU87Ez+o?=
 =?us-ascii?Q?6DnTzgBDWLkLWpNltgWSv3qyhDtMUs4y7ZdPnUELA81IR6XmegA1/uKtAhrj?=
 =?us-ascii?Q?kDq7iq3Xhbbw/yw7AanHUZj2HGHy1XZ8x1iaPvvmc7raO26Q+qwzkfuHBsMj?=
 =?us-ascii?Q?mt11wdtUb0L1KRKbSN6cjSD7P2Jgrig+NMuGzMpNP9+TQ16wxrP1ebOmd2dL?=
 =?us-ascii?Q?EZQj/cwbfF8dgmpfzyNx65oedF6dyRmmb1mo7LIaogfw73cGfMWiPopMfS/o?=
 =?us-ascii?Q?FF/cvmbHCRTtVL8SfVKPS7T5uO8t7zuAAKnZ6W0V7ONgtcq6X2y77cWFFcrg?=
 =?us-ascii?Q?FWYeFAp8M/cZ9xc/b8suWd0FQYPYYD0Cf5uG99j4Pt9U4WPjSlll4L5M65Fq?=
 =?us-ascii?Q?Zk0N12wB1YrwTAifPgIKeiwlSFU0evONzjDym6tySC12wp6zpeAmiDe5tGkE?=
 =?us-ascii?Q?ubTPysr2bWGuVo4iz7eJWosytxlMcDFR7PZCS6ocqbmEVl9Ra4SSX0p9Mzx8?=
 =?us-ascii?Q?ecJM9vL/fzlSd51J5yJdDIkImdstGwwKZoFnBWIyUSA5mB2JfowSCuuS8FRc?=
 =?us-ascii?Q?9lWsFqe66Ks1aY+FoCFnuDuBUfme/oOdCoVR4UsgTCLbNTGopx07kc3Y4ckF?=
 =?us-ascii?Q?nHpOGTq9PhXsfZYdikh6v/7c4XixW9sezHUsWZpbhsPaOb2yuZ2CDMw5WYXR?=
 =?us-ascii?Q?+Ra66htq8ff2tD43+gNTBURtx+jOmnecnsfZCPWWLrvj8V9zRst2XIOtukG5?=
 =?us-ascii?Q?VX+pnicv0PhefA1sdsXqYV+5Ad+3m5wVGzEgvLqS/wH3cILaBgpKcimyq2sW?=
 =?us-ascii?Q?4y5Tf1jYT3dQXuyClZ/uNYLZzaClj9Vqo2PWZVydJh9cAc2xrtMq7nlxZ2vx?=
 =?us-ascii?Q?lPwHq6kHDuEvESeLMzZ+q2h0yzvKjWbA8Oc4BHtCqbzON1byZceCIKYAY+Gb?=
 =?us-ascii?Q?0FXYz7/cLbEmXxeoEuivu4guBgh4HnSI29OzVzrlqK4uNLAoEwAOYw2c2BVw?=
 =?us-ascii?Q?V8EZIpaZzRRnu4oMLGwehdjkxJnB9Xedmc9zxmGwEe/BwaSvucuKbCzxNLdq?=
 =?us-ascii?Q?cwbc+3XOdNsaSbyfpTRiuXSqkGRCfJkP4N7shSDAErC0RfooIsopKU9Fz7Ft?=
 =?us-ascii?Q?eHtpS7KA16LeJB92j4XvtqpVbXDytcfgzKaf1b+CQPPINiOc0PrLLc4MlDzk?=
 =?us-ascii?Q?vRFayUeR8c9jwfn3lRIR8KMXwhd9Tgp08HDKsZvpRcUJxBUchG4O9XC1iY2a?=
 =?us-ascii?Q?2jp1InfljUHOy5J/f6T/QxEhfZOxqPWjFaYIYrWVX8pJRkgLBSxT736c2a+i?=
 =?us-ascii?Q?Lvno2vLP7XfN1wsBI3T0hv0=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d6eedc-ea86-4f5b-029f-08d9b632bb9b
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 07:58:46.2779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JiMHFOGnVpBaKEIyAZe9Zci4U3UmZaSlfI6fY8/K9YqFP+EL7WfC6IITSXGz2Nd1syKBmtiiQ26QprO+ocGOpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR06MB2462
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Signed-off-by: Yihao Han <hanyihao@vivo.com>
---
 drivers/scsi/bfa/bfad_attr.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/bfa/bfad_attr.c b/drivers/scsi/bfa/bfad_attr.c
index f46989bd083c..662f1e66c22f 100644
--- a/drivers/scsi/bfa/bfad_attr.c
+++ b/drivers/scsi/bfa/bfad_attr.c
@@ -711,7 +711,7 @@ bfad_im_serial_num_show(struct device *dev, struct device_attribute *attr,
 	char serial_num[BFA_ADAPTER_SERIAL_NUM_LEN];
 
 	bfa_get_adapter_serial_num(&bfad->bfa, serial_num);
-	return snprintf(buf, PAGE_SIZE, "%s\n", serial_num);
+	return sysfs_emit(buf, "%s\n", serial_num);
 }
 
 static ssize_t
@@ -725,7 +725,7 @@ bfad_im_model_show(struct device *dev, struct device_attribute *attr,
 	char model[BFA_ADAPTER_MODEL_NAME_LEN];
 
 	bfa_get_adapter_model(&bfad->bfa, model);
-	return snprintf(buf, PAGE_SIZE, "%s\n", model);
+	return sysfs_emit(buf, "%s\n", model);
 }
 
 static ssize_t
@@ -805,7 +805,7 @@ bfad_im_model_desc_show(struct device *dev, struct device_attribute *attr,
 		snprintf(model_descr, BFA_ADAPTER_MODEL_DESCR_LEN,
 			"Invalid Model");
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", model_descr);
+	return sysfs_emit(buf, "%s\n", model_descr);
 }
 
 static ssize_t
@@ -819,7 +819,7 @@ bfad_im_node_name_show(struct device *dev, struct device_attribute *attr,
 	u64        nwwn;
 
 	nwwn = bfa_fcs_lport_get_nwwn(port->fcs_port);
-	return snprintf(buf, PAGE_SIZE, "0x%llx\n", cpu_to_be64(nwwn));
+	return sysfs_emit(buf, "0x%llx\n", cpu_to_be64(nwwn));
 }
 
 static ssize_t
@@ -836,7 +836,7 @@ bfad_im_symbolic_name_show(struct device *dev, struct device_attribute *attr,
 	bfa_fcs_lport_get_attr(&bfad->bfa_fcs.fabric.bport, &port_attr);
 	strlcpy(symname, port_attr.port_cfg.sym_name.symname,
 			BFA_SYMNAME_MAXLEN);
-	return snprintf(buf, PAGE_SIZE, "%s\n", symname);
+	return sysfs_emit(buf, "%s\n", symname);
 }
 
 static ssize_t
@@ -850,14 +850,14 @@ bfad_im_hw_version_show(struct device *dev, struct device_attribute *attr,
 	char hw_ver[BFA_VERSION_LEN];
 
 	bfa_get_pci_chip_rev(&bfad->bfa, hw_ver);
-	return snprintf(buf, PAGE_SIZE, "%s\n", hw_ver);
+	return sysfs_emit(buf, "%s\n", hw_ver);
 }
 
 static ssize_t
 bfad_im_drv_version_show(struct device *dev, struct device_attribute *attr,
 				char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%s\n", BFAD_DRIVER_VERSION);
+	return sysfs_emit(buf, "%s\n", BFAD_DRIVER_VERSION);
 }
 
 static ssize_t
@@ -871,7 +871,7 @@ bfad_im_optionrom_version_show(struct device *dev,
 	char optrom_ver[BFA_VERSION_LEN];
 
 	bfa_get_adapter_optrom_ver(&bfad->bfa, optrom_ver);
-	return snprintf(buf, PAGE_SIZE, "%s\n", optrom_ver);
+	return sysfs_emit(buf, "%s\n", optrom_ver);
 }
 
 static ssize_t
@@ -885,7 +885,7 @@ bfad_im_fw_version_show(struct device *dev, struct device_attribute *attr,
 	char fw_ver[BFA_VERSION_LEN];
 
 	bfa_get_adapter_fw_ver(&bfad->bfa, fw_ver);
-	return snprintf(buf, PAGE_SIZE, "%s\n", fw_ver);
+	return sysfs_emit(buf, "%s\n", fw_ver);
 }
 
 static ssize_t
@@ -897,7 +897,7 @@ bfad_im_num_of_ports_show(struct device *dev, struct device_attribute *attr,
 			(struct bfad_im_port_s *) shost->hostdata[0];
 	struct bfad_s *bfad = im_port->bfad;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n",
+	return sysfs_emit(buf, "%d\n",
 			bfa_get_nports(&bfad->bfa));
 }
 
@@ -905,7 +905,7 @@ static ssize_t
 bfad_im_drv_name_show(struct device *dev, struct device_attribute *attr,
 				char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%s\n", BFAD_DRIVER_NAME);
+	return sysfs_emit(buf, "%s\n", BFAD_DRIVER_NAME);
 }
 
 static ssize_t
@@ -924,7 +924,7 @@ bfad_im_num_of_discovered_ports_show(struct device *dev,
 	rports = kcalloc(nrports, sizeof(struct bfa_rport_qualifier_s),
 			 GFP_ATOMIC);
 	if (rports == NULL)
-		return snprintf(buf, PAGE_SIZE, "Failed\n");
+		return sysfs_emit(buf, "Failed\n");
 
 	spin_lock_irqsave(&bfad->bfad_lock, flags);
 	bfa_fcs_lport_get_rport_quals(port->fcs_port, rports, &nrports);
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A5348BE5D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 06:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350887AbiALFdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 00:33:51 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:3126 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232195AbiALFdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 00:33:50 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20C0rxdu030267;
        Tue, 11 Jan 2022 21:33:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=ovI06iUmQmxUH/HT/eVJkzdI1ubz3683lpmY7xiuOTE=;
 b=KHPgOSzAlQh1/hg6Dz13qTqtBVksPfuE3QpZP7j1K/Rf0Uf1IRDzr01jgEUgLIVaOhdW
 wnTMW6KtHoQR6WXNcwIiMwcVd1/TQRG7Ew6OMiqebTr/IWg3TMD8z157QdRq/RAipJ+u
 KPASI0T7dZxEzdmZyyhmaGwXkGlZe/6LSdylYtZsJYA4q1GFgrXt/OedAOSyMbTzUkO4
 jX7+zlsVFODdCOg9s7AeDefhwTk8Y0wA4pKTMKcP+thgLt69B8lRqpBcxCYYVbavkywX
 65bM0UrLj7Nbzm00Ja0J/DlD7WYZXv9+sj/qo3O6YE4xC6VICgduyyyeCwREIkyYFwnV QQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3dhmuq8khj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jan 2022 21:33:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBwRaR6TSiTqPNq95KspQgPwpDpseGdWcp4fE78sxIWbYO6ursiYvqIMeO/98UZ9cLtjwbcXtHHg5GZhKB995/n5CWvvhZvm7DhYa20IFxOQjcvrmZ4/E8GW1+rcZeualnzQB9UVD1aDYmEqvyadZz+F2WpRisgUFx22yK2PHJ36kd+DYFCMtkWJtXMd/asMF/+6kOW+MStH06KQkuNoKHX350AuCKnRCCgAcJX2g91kyisEMqcfo9QwQoQbnj/f2mRGRWcixzLMVE0tl0T7nye2vYugRbVMf0YhoHFU270WyChbD3Y6zaQ6Ifbpieatx/pLlhcFHrEMAGwOgyRN3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovI06iUmQmxUH/HT/eVJkzdI1ubz3683lpmY7xiuOTE=;
 b=eqY2AVu1q5cJwSUtAX7fwQSyCESrebd4Oe5c72EYgbrj9RYsH7L6mQVlmLlXF/OFD7lnwxFCswI6lUA9D7ztcm7z3NWhvwj5to1B6UD9Jetc5EGIE9b96vAColL/GF6DHPSLzpKZBXVuJOUMWeP6BYd5sq2mrnuOjlrT9CRdb9ZQtIkoS3X6em70olpm7CKJOhDtkz8/LTqVtgQAln669McTQBt4FkWcnnII268KR2i825xI80mWAMZjxJPKDSg3HNjH4EDCIdgsHlXkUGtaYIvmFsBSEIZxtd8VZ+OyNJu7EvtvcVKSBmEiHEieFkNfpuJsK1SKCqHyEUgQbecl2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 158.140.1.147) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=cadence.com; dmarc=temperror action=none
 header.from=cadence.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovI06iUmQmxUH/HT/eVJkzdI1ubz3683lpmY7xiuOTE=;
 b=cuYb2tu7avYHFC3z8Dm2oFlrjT9eSO4DjxFJ2D5sVoBv4N2f740oYmaCtEG+YMBP8aXhBYi41rr1hPzwxVijfoBjN9k3HdQPfRUp7n4/S0ILnPYVIQFIPL/LAon4J/FBS88LCJ9t2Y3RkxN75FWT7aIqp46vyNKLXr4j2fLpxvM=
Received: from BN6PR16CA0039.namprd16.prod.outlook.com (2603:10b6:405:14::25)
 by DS7PR07MB7720.namprd07.prod.outlook.com (2603:10b6:5:2c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 12 Jan
 2022 05:33:38 +0000
Received: from BN8NAM12FT014.eop-nam12.prod.protection.outlook.com
 (2603:10b6:405:14:cafe::7e) by BN6PR16CA0039.outlook.office365.com
 (2603:10b6:405:14::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Wed, 12 Jan 2022 05:33:37 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 158.140.1.147) smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=cadence.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of cadence.com: DNS Timeout)
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 BN8NAM12FT014.mail.protection.outlook.com (10.13.183.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.4 via Frontend Transport; Wed, 12 Jan 2022 05:33:36 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 20C5XZ52026763
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 21:33:36 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 12 Jan 2022 06:33:04 +0100
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 12 Jan 2022 06:33:04 +0100
Received: from gli-login.cadence.com (10.187.128.100) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 12 Jan 2022 06:32:58 +0100
Received: from gli-login.cadence.com (localhost [127.0.0.1])
        by gli-login.cadence.com (8.14.4/8.14.4) with ESMTP id 20C5WwtF014857;
        Wed, 12 Jan 2022 06:32:58 +0100
Received: (from pawell@localhost)
        by gli-login.cadence.com (8.14.4/8.14.4/Submit) id 20C5WwjR014856;
        Wed, 12 Jan 2022 06:32:58 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <pawell@cadence.com>
Subject: [PATCH] usb: cdnsp: fix cdnsp_decode_trb function to properly handle ret value
Date:   Wed, 12 Jan 2022 06:32:37 +0100
Message-ID: <20220112053237.14309-1-pawell@gli-login.cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44a50e96-b382-457b-9641-08d9d58d14d8
X-MS-TrafficTypeDiagnostic: DS7PR07MB7720:EE_
X-Microsoft-Antispam-PRVS: <DS7PR07MB77203FE9FE8B484D40AA8E8CDD529@DS7PR07MB7720.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:323;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +9PdT+rXtqEkytraWVi6ci5gLhLCImIUVD0AcswPQwT8WV7X7H49brKSdOUtk/GyxOIafsOQQSRTctF92BcBUd9dg8kMS6gzEOBQIlXHrGZXEgS36XwGCmm0gp2EYw0inwPXpbctSiOc076E+XUcqyYV6sBSMd+M/b1VMxRkdYT1Q1kWW+CdkI+x8IYwcLiQiYmcVId+00b1T0kKRmDwLdPO7HET4cN3z4/pSLRuMA1k/BMoLAX13BgANiYC2TSBJQ5QLkVYEZbvxf9F8ShEDTcsGgGkXTgEs4de8P5hp26q+trKNPtpHKCZl3tLTgXde2sAZukBod8GgfqufmHiR62OIytni5mOpm8b5XVm6YWqSi7Q3fG9CIwewbt6xpScerdLik4nFASAaPqBrS4uSntDBoIMrtaf+/eSxNHAJ3paMspQTCturIUIf+y4tnpDkpNZ4JFUTrgjQmZkMsfC5WCjZucClCP8R+4ZjMZgdUgU8Rjxz+b6Wc1lrKXS0abi1P5JzWufJpoqX3rPG4Sgfc5Oe9EzPQ81m8LZQOisOIhKLyaJeDMD3GbSm3eFBeYfnWWIN4CwFQQPA13qbjtl081MmNRr3n4KPpTw7o5sbmYzH4sTSwOfIvL5ZHbYptikLzlfDAfT5DHfjOUNLQxY/M8d55Un6gWqupwUQoaz9iqP+hpca3SpsT6fQiTkk0Zn/+z/YbQs7UN1DRY8rX15tCD49G//DdFoJE/E8gguGxYDb3hz0HlOTFF9dV804BUyN1WDxcQKUiXiz0ucow9E5ZDufZq3RJyZN7Kko/NKPLg=
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(36092001)(46966006)(36840700001)(40470700002)(8676002)(6666004)(47076005)(54906003)(83380400001)(508600001)(2906002)(107886003)(7636003)(70206006)(356005)(8936002)(336012)(63350400001)(63370400001)(426003)(70586007)(5660300002)(186003)(42186006)(316002)(4326008)(1076003)(6916009)(26005)(82310400004)(40460700001)(30864003)(86362001)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 05:33:36.4448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a50e96-b382-457b-9641-08d9d58d14d8
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT014.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR07MB7720
X-Proofpoint-GUID: sqp32sroMndxBzzUd1WvpjAgXuLFI5jK
X-Proofpoint-ORIG-GUID: sqp32sroMndxBzzUd1WvpjAgXuLFI5jK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-12_02,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=577
 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201120033
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pawel Laszczak <pawell@cadence.com>

Variable ret in function cdnsp_decode_trb is initialized but not
used. To fix this compiler warning patch adds checking whether the
data buffer has not been overflowed.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/cdnsp-debug.h | 305 ++++++++++++++++----------------
 1 file changed, 154 insertions(+), 151 deletions(-)

diff --git a/drivers/usb/cdns3/cdnsp-debug.h b/drivers/usb/cdns3/cdnsp-debug.h
index a8776df2d4e0..f0ca865cce2a 100644
--- a/drivers/usb/cdns3/cdnsp-debug.h
+++ b/drivers/usb/cdns3/cdnsp-debug.h
@@ -182,208 +182,211 @@ static inline const char *cdnsp_decode_trb(char *str, size_t size, u32 field0,
 	int ep_id = TRB_TO_EP_INDEX(field3) - 1;
 	int type = TRB_FIELD_TO_TYPE(field3);
 	unsigned int ep_num;
-	int ret = 0;
+	int ret;
 	u32 temp;
 
 	ep_num = DIV_ROUND_UP(ep_id, 2);
 
 	switch (type) {
 	case TRB_LINK:
-		ret += snprintf(str, size,
-				"LINK %08x%08x intr %ld type '%s' flags %c:%c:%c:%c",
-				field1, field0, GET_INTR_TARGET(field2),
-				cdnsp_trb_type_string(type),
-				field3 & TRB_IOC ? 'I' : 'i',
-				field3 & TRB_CHAIN ? 'C' : 'c',
-				field3 & TRB_TC ? 'T' : 't',
-				field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = snprintf(str, size,
+			       "LINK %08x%08x intr %ld type '%s' flags %c:%c:%c:%c",
+			       field1, field0, GET_INTR_TARGET(field2),
+			       cdnsp_trb_type_string(type),
+			       field3 & TRB_IOC ? 'I' : 'i',
+			       field3 & TRB_CHAIN ? 'C' : 'c',
+			       field3 & TRB_TC ? 'T' : 't',
+			       field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_TRANSFER:
 	case TRB_COMPLETION:
 	case TRB_PORT_STATUS:
 	case TRB_HC_EVENT:
-		ret += snprintf(str, size,
-				"ep%d%s(%d) type '%s' TRB %08x%08x status '%s'"
-				" len %ld slot %ld flags %c:%c",
-				ep_num, ep_id % 2 ? "out" : "in",
-				TRB_TO_EP_INDEX(field3),
-				cdnsp_trb_type_string(type), field1, field0,
-				cdnsp_trb_comp_code_string(GET_COMP_CODE(field2)),
-				EVENT_TRB_LEN(field2), TRB_TO_SLOT_ID(field3),
-				field3 & EVENT_DATA ? 'E' : 'e',
-				field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = snprintf(str, size,
+			       "ep%d%s(%d) type '%s' TRB %08x%08x status '%s'"
+			       " len %ld slot %ld flags %c:%c",
+			       ep_num, ep_id % 2 ? "out" : "in",
+			       TRB_TO_EP_INDEX(field3),
+			       cdnsp_trb_type_string(type), field1, field0,
+			       cdnsp_trb_comp_code_string(GET_COMP_CODE(field2)),
+			       EVENT_TRB_LEN(field2), TRB_TO_SLOT_ID(field3),
+			       field3 & EVENT_DATA ? 'E' : 'e',
+			       field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_MFINDEX_WRAP:
-		ret += snprintf(str, size, "%s: flags %c",
-				cdnsp_trb_type_string(type),
-				field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = snprintf(str, size, "%s: flags %c",
+			       cdnsp_trb_type_string(type),
+			       field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_SETUP:
-		ret += snprintf(str, size,
-				"type '%s' bRequestType %02x bRequest %02x "
-				"wValue %02x%02x wIndex %02x%02x wLength %d "
-				"length %ld TD size %ld intr %ld Setup ID %ld "
-				"flags %c:%c:%c",
-				cdnsp_trb_type_string(type),
-				field0 & 0xff,
-				(field0 & 0xff00) >> 8,
-				(field0 & 0xff000000) >> 24,
-				(field0 & 0xff0000) >> 16,
-				(field1 & 0xff00) >> 8,
-				field1 & 0xff,
-				(field1 & 0xff000000) >> 16 |
-				(field1 & 0xff0000) >> 16,
-				TRB_LEN(field2), GET_TD_SIZE(field2),
-				GET_INTR_TARGET(field2),
-				TRB_SETUPID_TO_TYPE(field3),
-				field3 & TRB_IDT ? 'D' : 'd',
-				field3 & TRB_IOC ? 'I' : 'i',
-				field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = snprintf(str, size,
+			       "type '%s' bRequestType %02x bRequest %02x "
+			       "wValue %02x%02x wIndex %02x%02x wLength %d "
+			       "length %ld TD size %ld intr %ld Setup ID %ld "
+			       "flags %c:%c:%c",
+			       cdnsp_trb_type_string(type),
+			       field0 & 0xff,
+			       (field0 & 0xff00) >> 8,
+			       (field0 & 0xff000000) >> 24,
+			       (field0 & 0xff0000) >> 16,
+			       (field1 & 0xff00) >> 8,
+			       field1 & 0xff,
+			       (field1 & 0xff000000) >> 16 |
+			       (field1 & 0xff0000) >> 16,
+			       TRB_LEN(field2), GET_TD_SIZE(field2),
+			       GET_INTR_TARGET(field2),
+			       TRB_SETUPID_TO_TYPE(field3),
+			       field3 & TRB_IDT ? 'D' : 'd',
+			       field3 & TRB_IOC ? 'I' : 'i',
+			       field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_DATA:
-		ret += snprintf(str, size,
-				"type '%s' Buffer %08x%08x length %ld TD size %ld "
-				"intr %ld flags %c:%c:%c:%c:%c:%c:%c",
-				cdnsp_trb_type_string(type),
-				field1, field0, TRB_LEN(field2),
-				GET_TD_SIZE(field2),
-				GET_INTR_TARGET(field2),
-				field3 & TRB_IDT ? 'D' : 'i',
-				field3 & TRB_IOC ? 'I' : 'i',
-				field3 & TRB_CHAIN ? 'C' : 'c',
-				field3 & TRB_NO_SNOOP ? 'S' : 's',
-				field3 & TRB_ISP ? 'I' : 'i',
-				field3 & TRB_ENT ? 'E' : 'e',
-				field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = snprintf(str, size,
+			       "type '%s' Buffer %08x%08x length %ld TD size %ld "
+			       "intr %ld flags %c:%c:%c:%c:%c:%c:%c",
+			       cdnsp_trb_type_string(type),
+			       field1, field0, TRB_LEN(field2),
+			       GET_TD_SIZE(field2),
+			       GET_INTR_TARGET(field2),
+			       field3 & TRB_IDT ? 'D' : 'i',
+			       field3 & TRB_IOC ? 'I' : 'i',
+			       field3 & TRB_CHAIN ? 'C' : 'c',
+			       field3 & TRB_NO_SNOOP ? 'S' : 's',
+			       field3 & TRB_ISP ? 'I' : 'i',
+			       field3 & TRB_ENT ? 'E' : 'e',
+			       field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_STATUS:
-		ret += snprintf(str, size,
-				"Buffer %08x%08x length %ld TD size %ld intr"
-				"%ld type '%s' flags %c:%c:%c:%c",
-				field1, field0, TRB_LEN(field2),
-				GET_TD_SIZE(field2),
-				GET_INTR_TARGET(field2),
-				cdnsp_trb_type_string(type),
-				field3 & TRB_IOC ? 'I' : 'i',
-				field3 & TRB_CHAIN ? 'C' : 'c',
-				field3 & TRB_ENT ? 'E' : 'e',
-				field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = snprintf(str, size,
+			       "Buffer %08x%08x length %ld TD size %ld intr"
+			       "%ld type '%s' flags %c:%c:%c:%c",
+			       field1, field0, TRB_LEN(field2),
+			       GET_TD_SIZE(field2),
+			       GET_INTR_TARGET(field2),
+			       cdnsp_trb_type_string(type),
+			       field3 & TRB_IOC ? 'I' : 'i',
+			       field3 & TRB_CHAIN ? 'C' : 'c',
+			       field3 & TRB_ENT ? 'E' : 'e',
+			       field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_NORMAL:
 	case TRB_ISOC:
 	case TRB_EVENT_DATA:
 	case TRB_TR_NOOP:
-		ret += snprintf(str, size,
-				"type '%s' Buffer %08x%08x length %ld "
-				"TD size %ld intr %ld "
-				"flags %c:%c:%c:%c:%c:%c:%c:%c:%c",
-				cdnsp_trb_type_string(type),
-				field1, field0, TRB_LEN(field2),
-				GET_TD_SIZE(field2),
-				GET_INTR_TARGET(field2),
-				field3 & TRB_BEI ? 'B' : 'b',
-				field3 & TRB_IDT ? 'T' : 't',
-				field3 & TRB_IOC ? 'I' : 'i',
-				field3 & TRB_CHAIN ? 'C' : 'c',
-				field3 & TRB_NO_SNOOP ? 'S' : 's',
-				field3 & TRB_ISP ? 'I' : 'i',
-				field3 & TRB_ENT ? 'E' : 'e',
-				field3 & TRB_CYCLE ? 'C' : 'c',
-				!(field3 & TRB_EVENT_INVALIDATE) ? 'V' : 'v');
+		ret = snprintf(str, size,
+			       "type '%s' Buffer %08x%08x length %ld "
+			       "TD size %ld intr %ld "
+			       "flags %c:%c:%c:%c:%c:%c:%c:%c:%c",
+			       cdnsp_trb_type_string(type),
+			       field1, field0, TRB_LEN(field2),
+			       GET_TD_SIZE(field2),
+			       GET_INTR_TARGET(field2),
+			       field3 & TRB_BEI ? 'B' : 'b',
+			       field3 & TRB_IDT ? 'T' : 't',
+			       field3 & TRB_IOC ? 'I' : 'i',
+			       field3 & TRB_CHAIN ? 'C' : 'c',
+			       field3 & TRB_NO_SNOOP ? 'S' : 's',
+			       field3 & TRB_ISP ? 'I' : 'i',
+			       field3 & TRB_ENT ? 'E' : 'e',
+			       field3 & TRB_CYCLE ? 'C' : 'c',
+			       !(field3 & TRB_EVENT_INVALIDATE) ? 'V' : 'v');
 		break;
 	case TRB_CMD_NOOP:
 	case TRB_ENABLE_SLOT:
-		ret += snprintf(str, size, "%s: flags %c",
-				cdnsp_trb_type_string(type),
-				field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = snprintf(str, size, "%s: flags %c",
+			       cdnsp_trb_type_string(type),
+			       field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_DISABLE_SLOT:
-		ret += snprintf(str, size, "%s: slot %ld flags %c",
-				cdnsp_trb_type_string(type),
-				TRB_TO_SLOT_ID(field3),
-				field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = snprintf(str, size, "%s: slot %ld flags %c",
+			       cdnsp_trb_type_string(type),
+			       TRB_TO_SLOT_ID(field3),
+			       field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_ADDR_DEV:
-		ret += snprintf(str, size,
-				"%s: ctx %08x%08x slot %ld flags %c:%c",
-				cdnsp_trb_type_string(type), field1, field0,
-				TRB_TO_SLOT_ID(field3),
-				field3 & TRB_BSR ? 'B' : 'b',
-				field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = snprintf(str, size,
+			       "%s: ctx %08x%08x slot %ld flags %c:%c",
+			       cdnsp_trb_type_string(type), field1, field0,
+			       TRB_TO_SLOT_ID(field3),
+			       field3 & TRB_BSR ? 'B' : 'b',
+			       field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_CONFIG_EP:
-		ret += snprintf(str, size,
-				"%s: ctx %08x%08x slot %ld flags %c:%c",
-				cdnsp_trb_type_string(type), field1, field0,
-				TRB_TO_SLOT_ID(field3),
-				field3 & TRB_DC ? 'D' : 'd',
-				field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = snprintf(str, size,
+			       "%s: ctx %08x%08x slot %ld flags %c:%c",
+			       cdnsp_trb_type_string(type), field1, field0,
+			       TRB_TO_SLOT_ID(field3),
+			       field3 & TRB_DC ? 'D' : 'd',
+			       field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_EVAL_CONTEXT:
-		ret += snprintf(str, size,
-				"%s: ctx %08x%08x slot %ld flags %c",
-				cdnsp_trb_type_string(type), field1, field0,
-				TRB_TO_SLOT_ID(field3),
-				field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = snprintf(str, size,
+			       "%s: ctx %08x%08x slot %ld flags %c",
+			       cdnsp_trb_type_string(type), field1, field0,
+			       TRB_TO_SLOT_ID(field3),
+			       field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_RESET_EP:
 	case TRB_HALT_ENDPOINT:
 	case TRB_FLUSH_ENDPOINT:
-		ret += snprintf(str, size,
-				"%s: ep%d%s(%d) ctx %08x%08x slot %ld flags %c",
-				cdnsp_trb_type_string(type),
-				ep_num, ep_id % 2 ? "out" : "in",
-				TRB_TO_EP_INDEX(field3), field1, field0,
-				TRB_TO_SLOT_ID(field3),
-				field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = snprintf(str, size,
+			       "%s: ep%d%s(%d) ctx %08x%08x slot %ld flags %c",
+			       cdnsp_trb_type_string(type),
+			       ep_num, ep_id % 2 ? "out" : "in",
+			       TRB_TO_EP_INDEX(field3), field1, field0,
+			       TRB_TO_SLOT_ID(field3),
+			       field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_STOP_RING:
-		ret += snprintf(str, size,
-				"%s: ep%d%s(%d) slot %ld sp %d flags %c",
-				cdnsp_trb_type_string(type),
-				ep_num, ep_id % 2 ? "out" : "in",
-				TRB_TO_EP_INDEX(field3),
-				TRB_TO_SLOT_ID(field3),
-				TRB_TO_SUSPEND_PORT(field3),
-				field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = snprintf(str, size,
+			       "%s: ep%d%s(%d) slot %ld sp %d flags %c",
+			       cdnsp_trb_type_string(type),
+			       ep_num, ep_id % 2 ? "out" : "in",
+			       TRB_TO_EP_INDEX(field3),
+			       TRB_TO_SLOT_ID(field3),
+			       TRB_TO_SUSPEND_PORT(field3),
+			       field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_SET_DEQ:
-		ret += snprintf(str, size,
-				"%s: ep%d%s(%d) deq %08x%08x stream %ld slot %ld  flags %c",
-				cdnsp_trb_type_string(type),
-				ep_num, ep_id % 2 ? "out" : "in",
-				TRB_TO_EP_INDEX(field3), field1, field0,
-				TRB_TO_STREAM_ID(field2),
-				TRB_TO_SLOT_ID(field3),
-				field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = snprintf(str, size,
+			       "%s: ep%d%s(%d) deq %08x%08x stream %ld slot %ld  flags %c",
+			       cdnsp_trb_type_string(type),
+			       ep_num, ep_id % 2 ? "out" : "in",
+			       TRB_TO_EP_INDEX(field3), field1, field0,
+			       TRB_TO_STREAM_ID(field2),
+			       TRB_TO_SLOT_ID(field3),
+			       field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_RESET_DEV:
-		ret += snprintf(str, size, "%s: slot %ld flags %c",
-				cdnsp_trb_type_string(type),
-				TRB_TO_SLOT_ID(field3),
-				field3 & TRB_CYCLE ? 'C' : 'c');
+		ret = snprintf(str, size, "%s: slot %ld flags %c",
+			       cdnsp_trb_type_string(type),
+			       TRB_TO_SLOT_ID(field3),
+			       field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_ENDPOINT_NRDY:
-		temp  = TRB_TO_HOST_STREAM(field2);
-
-		ret += snprintf(str, size,
-				"%s: ep%d%s(%d) H_SID %x%s%s D_SID %lx flags %c:%c",
-				cdnsp_trb_type_string(type),
-				ep_num, ep_id % 2 ? "out" : "in",
-				TRB_TO_EP_INDEX(field3), temp,
-				temp == STREAM_PRIME_ACK ? "(PRIME)" : "",
-				temp == STREAM_REJECTED ? "(REJECTED)" : "",
-				TRB_TO_DEV_STREAM(field0),
-				field3 & TRB_STAT ? 'S' : 's',
-				field3 & TRB_CYCLE ? 'C' : 'c');
+		temp = TRB_TO_HOST_STREAM(field2);
+
+		ret = snprintf(str, size,
+			       "%s: ep%d%s(%d) H_SID %x%s%s D_SID %lx flags %c:%c",
+			       cdnsp_trb_type_string(type),
+			       ep_num, ep_id % 2 ? "out" : "in",
+			       TRB_TO_EP_INDEX(field3), temp,
+			       temp == STREAM_PRIME_ACK ? "(PRIME)" : "",
+			       temp == STREAM_REJECTED ? "(REJECTED)" : "",
+			       TRB_TO_DEV_STREAM(field0),
+			       field3 & TRB_STAT ? 'S' : 's',
+			       field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	default:
-		ret += snprintf(str, size,
-				"type '%s' -> raw %08x %08x %08x %08x",
-				cdnsp_trb_type_string(type),
-				field0, field1, field2, field3);
+		ret = snprintf(str, size,
+			       "type '%s' -> raw %08x %08x %08x %08x",
+			       cdnsp_trb_type_string(type),
+			       field0, field1, field2, field3);
 	}
 
+	if (ret >= size)
+		pr_info("CDNSP: buffer overflowed.\n");
+
 	return str;
 }
 
-- 
2.25.1


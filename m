Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B43F4945E9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 03:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358234AbiATC6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 21:58:40 -0500
Received: from mail-bn8nam11on2113.outbound.protection.outlook.com ([40.107.236.113]:14561
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230235AbiATC6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 21:58:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6Jl1inrKWaOUZaDWop22eI10yiwoe//LYDkhxBtInblcrf8cFm0ek3Q4I0zZgGpTjM9l3yZdppNXYBkqALuEmYJ5/uTIwGhWpEKaRUBH8cAvOJMC2eGXOdtlVyrBCocx+ucKEudlD8wxOF1Bfu0z9cnH6EFyvxnEbc4Y8+Im4AF/Mo2H8sS9HrMFVTc/wRZpEiRp/rHN4w/XcBhP6yk1KdHRZrtKNkQs8e5EN4AeXK6m5Vs1WRB8ihMoLt1avYj4MMvx7KGD/7VvUAL7Bmvs0YWelX7br1ufQmO0R92cJvKSLJgljQuUYoNvlgMgdCEEMWSdgV6Jms90PTfpNiR1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3i/3FdaePamRhByxo+DB9kGI/eUUW1oNDZcsyQvB/s=;
 b=ZiCiDDcH/saC9iVah7Yx+fdkZBb8TXLvExSrkSfejZSxN8fVJXxeVuek4ubj5trJ8sgcoI37caqph6wiV3vHBvd/U/DaP+u+fYUUzfnhLHBdV6JJPvHuVMMXfu4CJxufvVGpzIuX3iyAUej84rTWG/niiVGFPNHT7gVDq4KZ0GTEvRq1IIn772BjrFemhkNJKqzJFTxPkATIHkwv2V9SWJ4Cf2lIOVCLyapr03gS95zlTK0CVXEXxggL9ALAyT3Ibibfnywu9q4nMlIuPHnazbTBM5+1Syy4Az2tog8yb1gz68Lm+Q7sxBjPnkvFi/ss4Bhq2q3NtEgQC5V7DwS+0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3i/3FdaePamRhByxo+DB9kGI/eUUW1oNDZcsyQvB/s=;
 b=ErLl0WRY/dJFzN12z/+dTnMt3aZIAqFiFNfdP+EjS5lfUu0sQdNE+6uj97r8CBpRXeD6jdzCglYuod1lYxH3PB4ZvUCtEoaSfAkN8o+2QrGZy8ZYW0fFccale47bhv6H5IqVARcWMVzpnxhTzdXyhZkZKL0pplopomCBoYwRqkg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 BY5PR01MB5827.prod.exchangelabs.com (2603:10b6:a03:1c9::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.8; Thu, 20 Jan 2022 02:58:36 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::c4f4:4df1:380a:2ad8]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::c4f4:4df1:380a:2ad8%5]) with mapi id 15.20.4909.008; Thu, 20 Jan 2022
 02:58:35 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rafael@kernel.org, linux@armlinux.org.uk
Cc:     lenb@kernel.org, robert.moore@intel.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, patches@amperecomputing.com,
        scott@os.amperecomputing.com, darren@os.amperecomputing.com,
        james.morse@arm.com
Subject: [PATCH v4 0/2] ACPI: Arm Generic Diagnostic Dump and Reset device
Date:   Wed, 19 Jan 2022 18:57:57 -0800
Message-Id: <20220120025759.8630-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0337.namprd03.prod.outlook.com
 (2603:10b6:610:11a::27) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f90f45f-4319-422d-ac47-08d9dbc0bfc2
X-MS-TrafficTypeDiagnostic: BY5PR01MB5827:EE_
X-Microsoft-Antispam-PRVS: <BY5PR01MB5827BCF056436466E01C34889D5A9@BY5PR01MB5827.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ljgNYY6nWmac5LCS0VE5ydY16g13Ev651zhL7KKWO1bgC3qMQotw/z1xng7SksL9OsAfPDKfK3tuMM0a9PNbj/v8GONLLjm73a9cDj4en9lbTXNc2tnAw6kgixOVCX1EtLpAOTW7AoT2K2vBvDCAklZ0iN6GO8ueT9mtXRvr98XIXFbY3mq/2TQ1DhUcAsorvW8Pj1enBnl3xUgUK8eSBOuxomXRQna1xGKQsk1+5RWWm5fwtWX+qDTwkbl8c6wZGYiQ3qs4mEH3TWPgNgI4l0FvQL8jfiAT5p1HBmRckVQ3o1ukAG142VNaWCjIlAFi0A7vPEco5skWIoJvSy4zeOeu1DOtdvhp46DAfmia44fmo0BPoVAwy2xoUokf6HZpUFC3PgYUgEiD+yUkgIAD5Yu75iQFqH7S0NZOi9X4PgqZ/8+fcb3gdSNDboFtp1baveymRVtCGFpyPfvQoExxU6hkeCN2Jh+xfp0KR8Q+L+7CLkGgBGfsXZz5WB5Jvwtvj1AXQ5dYt3Zr0GaPE3loQSyhMJo19lpkofDiQqXuUjwXTBUqbFFtejjdaC5nXyvVH+MV69PfWklbsIQU3Vtc5qACThZKyKLKY1yTkky6NWpiieiF8t0DDZIhXL3OOIZFgzSUdu5M4SDNqv6C0fVWF4LmzRfnniHSPCAv4WzM2OVZ19q8XcBSJ1YTKSv3XG2LEw6CEK+9dQSnc6bxDSS9M+H2dlLkkJPnt5Cixo5N/zPSFjdJ/TVULQAv6x5V4ED3Y/pwPh6FCeQTuhooCfElu5L1G1j/hIvtn0+FeYTVQ8HZoT3cNznd3o2UklcLIDdyvWjwMkVsj/aufEWM5Q85CSxzk7mVCszluzs8LZM3bw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1076003)(66946007)(66556008)(66476007)(6512007)(38350700002)(86362001)(38100700002)(316002)(6506007)(5660300002)(2906002)(508600001)(2616005)(52116002)(4326008)(7416002)(966005)(186003)(83380400001)(6666004)(8936002)(8676002)(6486002)(26005)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pvRzMCVNtMKJIfTtkMlQBP5Ycni85v4eDAUEEuxWtJRChUTU0B2mr/PpQRit?=
 =?us-ascii?Q?g7tDiu2pWlv3DrduaL2EPTwG+jDgvpXwsWpzWOe8Gtxih2YOER0wt8Ze1ZE1?=
 =?us-ascii?Q?2TM1c33LJQaCeqa/KkQPZ7Ku8gzojznSa1eAwuQjr685P1ZDFqUWxZxux0T0?=
 =?us-ascii?Q?stRkbgEuO+cmuleqpq4f24WzoHIcOVpy5WKncae8kiZ0LUmVvEaxVSy7rcEi?=
 =?us-ascii?Q?YGjTN7qwuERO5nnKQuB3ywErz2hzGERY8+itplrzdbAypJXQbA1w9bnAmSOr?=
 =?us-ascii?Q?UXvpMeoqXTW/Wsa1xjUoXK+GQbHrBdqu//tf3hOIVSX8/mLqmrBBOyu5QU+J?=
 =?us-ascii?Q?h+mOqdRcUSpd8OJArcbBbD7baeGlIb9EiEo3iFIHO2diI2rlV50Ia7LweotC?=
 =?us-ascii?Q?ZUwrqrfUxlovt2Z0mWkrp4JpdPXZaGUZTMFJnu8kD5N5cXxZzij2kKWqNLmh?=
 =?us-ascii?Q?VQaemgezW/eEyKzhTSVJFeE0d4pfdk11Ufgvk3De44OcbH6/sMEyfAc6WMYa?=
 =?us-ascii?Q?2egxw7oP/bwSA6cRv3mIYZApb4K9imzKR/auxmtSe0lcGcxLMKg/TYrQW9pp?=
 =?us-ascii?Q?CwqS6wNTXzaw92LkGpKrIcb8YKcZvFPdluWs4JDNvuyRoOt6KBKo52MvVWYb?=
 =?us-ascii?Q?FIWyBwC05ZFax2qtc84RbZ0xgHTrbKaivxf9/ukUYJCdeh53M08RSYDFWSHC?=
 =?us-ascii?Q?n/zkXsPKN14U+LHKc0dAquZVt7dymlRRwG7BQ+y+6uV5B+dcOax5VnKpst0z?=
 =?us-ascii?Q?GmsoBETkvUcQIy2Bh3p7zAVrk/lSIoVrrxXtNGC8qxmFuAjHx8ko9lVbZKoK?=
 =?us-ascii?Q?2GO3FS++Fl1gdjrvf4jSrIvdUiWyNPV7/23KrVdBK4Wbtg/p4BbxYlZ6a7pW?=
 =?us-ascii?Q?YiyTM1v413/xPLjTdBdTyQWPeiEUTIRsOB2+WEVjsthl0f9AwDtmfpVuZwE5?=
 =?us-ascii?Q?oQDTz9Zq8B4zVV5Myr6f7+lWwF4JaFdRHU8gW8XcAHYUaZufmyC8xmcFt2M5?=
 =?us-ascii?Q?aPPJ3Q2HGZ/m/g/SNtyQAH++v/dEMQ6G7FrIZW8P+vslWwP0QtJNyGneSBZD?=
 =?us-ascii?Q?vqIAs4H+VT3JstDfaOVVt/06YCytVN5cAfGxs0SwxK64REAEISBeJlOESIbf?=
 =?us-ascii?Q?wYUS97tQlVzjaOsSIeEMueQuI8PlEhQ60wEe4zeyS5STiYuPV0gLZ6NHOPnk?=
 =?us-ascii?Q?FUPhRPzb02XVVGVi5Kzlmqud3Ap9/YtFXYE0RlCsc7LMj7j/EiDWuFTW/Kss?=
 =?us-ascii?Q?tV4+83mbEnEBJgn+RmVzO//XcdDHujcjolsBn96QoH2/NDeYy3MMYtjCpXKx?=
 =?us-ascii?Q?scfcJ8h080FzvbaD2BfSoHiARVIjku9FYrfnOHSQGr31WJxtYNcRqQQbmV6H?=
 =?us-ascii?Q?/bI6/3QMHIVPXX4wKWaHjjpadSmbeKrzn5FOsO15mIBy2jusqa4INxJt4OtR?=
 =?us-ascii?Q?YaMPwHAeZR70hf1Az4JIO6icKxtwA/zt2pOaAgPf9G8AK1muL4zSkbkCnvqB?=
 =?us-ascii?Q?FXBZIERUkU/nAgES1/KLdrRJ8z+xmorHU2JzTpo056rvZqw4p0tWSwncRTX6?=
 =?us-ascii?Q?EN7j13lEEGHS+elSuXlbEDrwh4hDfhDyiul1vij1b/b+CgjSM6b4z1otMGuk?=
 =?us-ascii?Q?BBelvjCKPF6xDNJ7FHJrEP3MAzQb45Pv6c4mZ+kVSDHgmn/xurcO+ah6PaFX?=
 =?us-ascii?Q?ycLjduV4ETbuUR+0UhNAF+2hv3zZ5xexDQ9uT7sJIWRtXOlQneciWihjq9Oo?=
 =?us-ascii?Q?kZnxLhA8hQ=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f90f45f-4319-422d-ac47-08d9dbc0bfc2
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 02:58:35.0951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LI9yA5Y+0OxD32L8R1qSSp0NqAyx3+SXXFhyiNAix3coaPx+AXkryZ5tgJryBp9KOvZhGJs+VJuLlfOIR13UO3jItSeL96JBa7BxbgEy1dhizNqlIA7lAo1XhGyZCwB7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR01MB5827
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm Generic Diagnostic Dump and Reset device enables a maintainer to
request OS to perform a diagnostic dump and reset a system via SDEI
event or an interrupt. This patchset adds support for the SDEI path.

I do have a patch to enable the interrupt path as well but I'm holding
it back since AGDI table is missing interrupt configuration fields
(trigger type etc.).

The recently published specification is available at
https://developer.arm.com/documentation/den0093/latest

The patchset was tested on Ampere Altra/Mt. Jade.

The patchset applies on top of
  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm bleeding-edge (fc720b592cc6)


From v1:
     * Moved pdata to the stack and dropped unnecessary kzalloc() in agdi_init()
     * Changed the ACPICA patch upstreaming order comment in the paragraph above

From v2:
     * The first patch was split. The most of it was merged to ACPICA project
       at first and later ported to linux-acpi
       (fd919e37cb15914c6fe13e13d530a4f732407c6d). The rest are in the first
       patch.

From v3:
     Fixed:
	* Moved header files in alphabetical order and removed unnecessary ones

     Not addressed:
 	* agdi_init() is still called from device_initcall() as it has to be
	  done after sdei_init()
	  (http://lists.infradead.org/pipermail/linux-arm-kernel/2022-January/709969.html)

	  Can be moved to acpi_init(), after Shuai Xue's patch get's approved
	  (http://lists.infradead.org/pipermail/linux-arm-kernel/2022-January/710268.html)


Ilkka Koskinen (2):
  ACPI: tables: Add AGDI to the list of known table signatures
  ACPI: AGDI: Add driver for Arm Generic Diagnostic Dump and Reset
    device

 drivers/acpi/arm64/Kconfig  |   8 +++
 drivers/acpi/arm64/Makefile |   1 +
 drivers/acpi/arm64/agdi.c   | 122 ++++++++++++++++++++++++++++++++++++
 drivers/acpi/tables.c       |   2 +-
 4 files changed, 132 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/arm64/agdi.c

-- 
2.17.1


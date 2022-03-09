Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752854D3CB5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238554AbiCIWMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237433AbiCIWMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:12:41 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6899A120EAE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:11:42 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 229KcpMM022261;
        Wed, 9 Mar 2022 22:10:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=Cc2ep90JpqHIfE2bebRlDdZ3yi8YZNS979Fh9o1mHcU=;
 b=dNwliiCpwTZGP1qy3yobk/s6sBbTUGT8Icj134XlsV227E0v4UfcDe/sK+Hghdjxp5QN
 lVpP5xYwswcx3v/XdW/4ZQnEI6P7STBO3AIQtSf0QrHQ6oE3ua4OlV6EL1ZASvWCrj70
 ap6OK30k+DOYLiU2dYcpKGTYtZgQ8eXpj3FZ6sOtcmSY/y4yUBLJ+hz1gWPU2HHtGOe2
 zJ9MamNFpTnCe/77hCgezb7FfGG4+kA8W4u6oubjXtkItAO9nXTbf8wAYrrfWeRBJ3kh
 9HlCFMTZfTLg0Ps5H+s34KybaT8YxF1p2jwcShGKak7TxPbpEKKmhpKK5K2JhMxy8KjK sA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekxf0ugjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 22:10:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 229M5JAP068027;
        Wed, 9 Mar 2022 22:10:00 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by aserp3020.oracle.com with ESMTP id 3ekyp36snd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 22:10:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsDcEZiBZfQBGYrvDQq6UpbqsQYhA5QfwK7pyRlNsfty/Tn2ba2nz8/m4yOuWTTWK/jonPKa6JHV1ZJ+Ndlhu/17VPr9OLtQSkPcRSJukQ8Z4Q2Q51803cnLMnGVQdRiIVRRMMV7ZDe5dxT6tcKLj4rC+mlnAeMQuBzVoS1kKJ3iAQaSUd9+5LDJaILkVnUXK39R83EsU4uOkNH2/VfGMQbD6wJ0hXnCbuJcQ0SSTgjccO1LDsvgTgS+aA7uq4Qr07ybc4fqEU27TICefjp1XwyCzRDeGiMJ2J3WuTWiPz0lGGehhlLJdz93A2pJ4YnQROWfPoBkyzn+jy48WbaNFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cc2ep90JpqHIfE2bebRlDdZ3yi8YZNS979Fh9o1mHcU=;
 b=CmanMif16ixWLG0m7U8zCAF6zUpNf7+vVb5CPdXk16rNq8TYBB12Q4ZhslaFRi9BLssEeDrmYfucIZzKdf0unSslDlJOPCZOhQ5Q8nEuXlkDy1QFkDab5o/QjUiDG6z4nBsRpYAhbp3XNWea4/jF+oDkhSpyPgdlc7qjpjU3hU0OMed+AgzPQ8mD0ANF9VET5uCkRtCoge808Nb8C2iZ+IQ0mrUl1rnhUgxvTYNVDKTfy7xbUiXAuNWiDQkx64h5yYSfOdciYMveN2oTHZ88wMLlm4/93jBkQRX2VmqvcINeTkoykU0uaHoPoNJmVnO99v6ak7XoBGP8O2RkTslq6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cc2ep90JpqHIfE2bebRlDdZ3yi8YZNS979Fh9o1mHcU=;
 b=Y+lgrWxr67vaqLwVKbtZfrDJImZ4gpiq+t4Tvmxi74Ykgg9NEvoEh822wqlPmnAANSRNOWtxW6/hu0wzoOWDPJxTyJAFTFHMJ6H+WP1xA0W1Hxm8r9qb7kBXJ05hE+Q+YNXPXEj3w4i7bMjE4zmpr+DOBZKV2v1EBy7ubSi9qJk=
Received: from SA1PR10MB5866.namprd10.prod.outlook.com (2603:10b6:806:22b::19)
 by SN4PR10MB5560.namprd10.prod.outlook.com (2603:10b6:806:203::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Wed, 9 Mar
 2022 22:09:58 +0000
Received: from SA1PR10MB5866.namprd10.prod.outlook.com
 ([fe80::e82a:9be1:793c:1702]) by SA1PR10MB5866.namprd10.prod.outlook.com
 ([fe80::e82a:9be1:793c:1702%4]) with mapi id 15.20.5061.021; Wed, 9 Mar 2022
 22:09:58 +0000
From:   Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     thomas.lendacky@amd.com, brijesh.singh@amd.com,
        kirill.shutemov@linux.intel.com, hpa@zytor.com,
        pbonzini@redhat.com, seanjc@google.com, srutherford@google.com,
        ashish.kalra@amd.com, darren.kenny@oracle.com,
        venu.busireddy@oracle.com, boris.ostrovsky@oracle.com,
        alejandro.j.jimenez@oracle.com
Subject: [RFC 0/3] Expose Confidential Computing capabilities on sysfs
Date:   Wed,  9 Mar 2022 17:06:05 -0500
Message-Id: <20220309220608.16844-1-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::25) To SA1PR10MB5866.namprd10.prod.outlook.com
 (2603:10b6:806:22b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 627d0dcb-f8cc-465a-a272-08da02198c7e
X-MS-TrafficTypeDiagnostic: SN4PR10MB5560:EE_
X-Microsoft-Antispam-PRVS: <SN4PR10MB55606787C7205C90E7596E15C70A9@SN4PR10MB5560.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1K72ZTFb+gLQs0gcYRvEV9AxWBTAKfOB3hYTPz0zrl4Ap48AcP4+dPinmtc8L6kVu2JRWN0wawQyF4HXKRc2TOIlKbFdcDvB07m9GlMND+niHivsnSdgJ+e5zFe/rdx+46AUfQ/1UpDcA/sGN/h7DS8fjo9KSjLo4jSz03rbwBqe8B/eFdJJoyrczhlCt/Zq9C/z4nyJtrMpa0kFSP8mc4L6oYzIKe1WQGxNCCctJVMqBYH6MelTlKPX9J6cHk8ZWV6Z2HIBkZofHF5yrbzyo6AhaWmQSihZjVGYnx/QJQ8dhwoCKElOjb4jQxNoOeGNAUyGrY3KcAryk0EplKTjvB7UODCNpqZl8+MOnSS8WyTj/epCw3fcEL/8jzK98hsHx47zcfaAI1n4b2z+wJSVPCdJwTHyTy3uSDkJqKrgxSMvcnAq6EL2DcLs6mWscyhdYZ4MzdGwbJrf/VwC5g8yuic6FvZWZ/GU2TeSEi3QOJB1SkYWH76SmoaCDCg6oahjcGolwkjj5vet/z4M0uOxpxp5z/OY3C/siwKvuWq06V+ZAeWd+rcH2aetePOfYt5ejX3qJ+rtPwPfiPlcUL9BWsI5WX/boaYVFLrYJVhlJhFOj/gzRvrGSejj/5US1MBi4doVpWQZYMghnHlEe395eiSPIjUiU6MqcBjovxfPXaCqt8fbzHF0nKvLeIe8nfkYvYRh5xOBysjCcd5UfvPM7YvvrAuPDFqq78/9IqHOf7Ic8w2BeeYB7SEipVgmXfxrG2yQWY8D0z5a4Ejm+VIVf4InBSD2dkTt+GL/WhKFRY4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5866.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(8676002)(4326008)(36756003)(86362001)(103116003)(107886003)(186003)(2616005)(1076003)(5660300002)(52116002)(966005)(6506007)(38350700002)(6666004)(7416002)(66946007)(6486002)(26005)(38100700002)(6512007)(508600001)(8936002)(66476007)(66556008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGxaME1DOHRybGRSVzcrWmdVcTQrNFNhYktoZ0dUSDNRbVhvcUNQM3p6MkNh?=
 =?utf-8?B?SnpBelBTamNwYk5DTjRZK014TzFjdkZzUmZDcGZYM2FuVFBDOXhyY0M5QXJK?=
 =?utf-8?B?UUlEa25NUW5jRENtcmNCMElPSXBpaHdSdisrZERMOHBvRHh2RmErcnk0SWtS?=
 =?utf-8?B?T2NoNDdPOFZ2MmRnSnRQTEM4ZUdSTzI4SGZCbm1uV1laOW1CNTF4UlZTckpB?=
 =?utf-8?B?QmlkT0sxZUtVTEpKbkJlOC9PRHQzQzBwZWFxQitDMUh0QkkwaU5heVlCd0V1?=
 =?utf-8?B?R0ZIN0tYZzFIcWQrdEpyWnJkRll1bWRoTmVnTWpuY3YrYnJuSDRFQ3BPbkVo?=
 =?utf-8?B?NW45c1RYVWZ3NkNGWERpYVVwanc4dWhFQktVVlBEUER4TXErc29tRXVNWDhH?=
 =?utf-8?B?cDJnYWVpeW9WOFg2dngxUUVqSjh6SW9vYWdIRXFvUDIwUWVqZkE3L1lXU3M2?=
 =?utf-8?B?azk1Yy9RcU05Wm9mRFd2UkdJdjhGSDRiVTNEN1dSeS9tSklsZUg0Uk1hWGto?=
 =?utf-8?B?NXAzTUZFV1kvbk9lVXZWeklCaTFHT0k2ZTFmNlBPY3JWWWwwbXFGUC9FSFY0?=
 =?utf-8?B?L2RqbjN5UnFVV1ZLc1Uxak5ZbHgxWjBPSmo3dEp6ajJOUXdXNGNFMEZyWEd1?=
 =?utf-8?B?c3ZMdkdkWmRhT0dyUXkzd3N5YW5vTHhteGJQZGVaZnN6YW03bnpLdytYUVBa?=
 =?utf-8?B?THBmSnM5MXV5MG9mNFpTek4yTXRta3lCWlZTSlU1SktSUDJEKzRrRTlmdTl5?=
 =?utf-8?B?R0pxc1JrWUJ0NkRrTkpDVko2Sm9xN1djbndmYjdmRmpLZEdFZEd2ekJ5Q3lG?=
 =?utf-8?B?a0NMMFdpaFdxN1ZsakNBRFRuaWdzTkpSNUVaS0dSZmpCeFA0THFMdzFrUGxH?=
 =?utf-8?B?VVhYenEybzhyZkRyekM3VEVqb05qS3pVa0psK1NKOXdGeVE3eXYwamxuMmdp?=
 =?utf-8?B?WUNBQnFhQ052OHYyYjVMVVIyTDNxZDRxWFl6eWtJRWhFT1NoMnBua21SczZU?=
 =?utf-8?B?cURTUVJPcFQ1OERuWUhZUTlTQTRhTmgvcFl2MjhBZjdIT1FTWGUyT01vMlN0?=
 =?utf-8?B?ZGQxSVFqUnZFc090TERndUxjZEVOMlJ0Y3VReDJ1YTNWc2U3RWdoRVhMbjVP?=
 =?utf-8?B?YWwxakhPMFpmUUxsZUZ3NzUyU1hqQXZPaDNXb1doN1d0TlZ5V3FvUmNTVTdn?=
 =?utf-8?B?RG1IblI4THlNRWRJbllkWXBYcWM1WkhWS21BMytOekU2ODZaZ1dpa0JmVjlI?=
 =?utf-8?B?MGt0TURzNVRSNG9VRFVGNzBWT0YvRXpIL1pURGFhd2gyMEpjNDc0UWJFemdk?=
 =?utf-8?B?TTlFNXVzd0JaNE9RaVhpYXEyckRxbnpaYXY0eWRCa0ZXclRad3o2TUFQSEph?=
 =?utf-8?B?aDVoNlNRRi9VeGp5MHVsVkxUdFY3Vm95OCtKa2xnZUNmUmpuekNCdUFZbVY3?=
 =?utf-8?B?N0lPN0x3TDVsMWtQbnJsMkVpaSs3WjhBTVJ5VFFXTXVQbjZMSmdSNllHZjZL?=
 =?utf-8?B?L2F0V2ZQUFk0NDVIc0d6ZnhURXVnUkZyU1dSNEkzUjdoN3NCVG5oS3UrY3Ft?=
 =?utf-8?B?ZEhjc1pnUWVtNGVDSnJaQ1FBdnMxb2FmakY1c2FFb3pydkpRSEk4S0lZYkln?=
 =?utf-8?B?c1dscEtrdTRlK1UxSG4wamV5aUh4NG82MHRMdUtycVVnck9YVVMzS3NjSDFa?=
 =?utf-8?B?SHJUL1hRbUZXd1VabHN1RW5maCszeGQ5ZmpvVHRtYkZSMVJta21OdFNrTXpW?=
 =?utf-8?B?cHR5cXdNV29wY2NLeHV3RnRVTlp5dmhWcUFmZ2xzU2dwQ1MrTG9hQ0EzTUFX?=
 =?utf-8?B?SXhHeFZTQnd5NWsva1VrM3hnOE5UYW1WNlArSzVtb0grWnRZcTdhSVFPZUxi?=
 =?utf-8?B?OW5keHFQWWxQK0lVVityNVREN2dIKzFZdGNCZmFWUGxUUTU0V3h5OVZWTWQv?=
 =?utf-8?B?U2E0cVR4N3JlS0hDMXVpRTRCazIyNloyVlZCajc1elEzVmpQR0hUWTdxZkE5?=
 =?utf-8?B?RktUcWMvdDVrN09PK2p6UHl5WTJMbWZuaTh2NUpRZG9mektWd21GRlpSeDM4?=
 =?utf-8?B?UThHaXpEOGVkOURLNDhEMXc3MG1pWVptazNJcndkVGJqWGF2bDZ0Z0R4M2xJ?=
 =?utf-8?B?YjRDT1FXcDdKeUplT1crbUlwRFFqZ3ZXM3p4TkN1ZFNpU3hKdW5xSFc1dnlu?=
 =?utf-8?B?enh1TmRDUFhnRFVqV2pzZUxEVVN5aDBCTjBmVGxDQjNTaW9nejRUMDJCS3B4?=
 =?utf-8?B?YzFEVThDcEd0SXJzZGNpN0VwVFdnPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 627d0dcb-f8cc-465a-a272-08da02198c7e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5866.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 22:09:58.2612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /0zn406drq9vQesm1waQCWmL88Y4bfbFWSpvwBv9j7wJPGILJcjG/yjt+a0ybuFd8O9FGhE9PpUyckaKgwaodO0qaq3uQF4TwcBj9J8BONQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5560
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10281 signatures=692062
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=969 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203090111
X-Proofpoint-ORIG-GUID: SNWlWqpQSl-9sVUqvRrXMVl04W_UNprg
X-Proofpoint-GUID: SNWlWqpQSl-9sVUqvRrXMVl04W_UNprg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given the growing number of Confidential Computing features (AMD SME/SEV, Intel
TDX), I believe it is useful to expose relevant state/parameters in sysfs.
e.g. For AMD memory encryption features, the distinction between possible states
(supported/enabled/active) is explained in the documentation at:

https://www.kernel.org/doc/Documentation/x86/amd-memory-encryption.txt

but there are currently no standard interfaces to determine state and other
relevant info (e.g. nr of SEV ASIDs) besides searching dmesg or manually reading
various CPUID leaves and MSRs.

This patchset implements a sysfs interface where only relevant attributes are
displayed depending on context (e.g. no SME entry or ASID attributes are created
when running on a guest)

On EPYC Milan host:

$ grep -r . /sys/kernel/mm/mem_encrypt/*
/sys/kernel/mm/mem_encrypt/c_bit_position:51
/sys/kernel/mm/mem_encrypt/sev/nr_sev_asid:509
/sys/kernel/mm/mem_encrypt/sev/status:enabled
/sys/kernel/mm/mem_encrypt/sev/nr_asid_available:509
/sys/kernel/mm/mem_encrypt/sev_es/nr_sev_es_asid:0
/sys/kernel/mm/mem_encrypt/sev_es/status:enabled
/sys/kernel/mm/mem_encrypt/sev_es/nr_asid_available:509
/sys/kernel/mm/mem_encrypt/sme/status:active

On SEV guest running on EPYC Milan host (displays only relevant entries):

$ grep -r . /sys/kernel/mm/mem_encrypt/*
/sys/kernel/mm/mem_encrypt/c_bit_position:51
/sys/kernel/mm/mem_encrypt/sev/status:active
/sys/kernel/mm/mem_encrypt/sev_es/status:unsupported

The full directory tree looks like:

/sys/kernel/mm/mem_encrypt/
├── c_bit_position
├── sev
│   ├── nr_asid_available
│   ├── nr_sev_asid
│   └── status
├── sev_es
│   ├── nr_asid_available
│   ├── nr_sev_es_asid
│   └── status
└── sme
    └── status

The goal is to be able to easily add new entries as new features (TDX, SEV-SNP)
are merged.

I'd appreciate any suggestions/comments.

Thank you,
Alejandro

Alejandro Jimenez (3):
  x86: Expose Secure Memory Encryption capabilities in sysfs
  x86: Expose SEV capabilities in sysfs
  x86: Expose SEV-ES capabilities in sysfs

 .../ABI/testing/sysfs-kernel-mm-mem-encrypt   |  88 +++++
 arch/x86/include/asm/mem_encrypt.h            |   6 +
 arch/x86/mm/mem_encrypt.c                     |  27 ++
 arch/x86/mm/mem_encrypt_amd.c                 | 320 ++++++++++++++++++
 4 files changed, 441 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-mem-encrypt

-- 
2.34.1


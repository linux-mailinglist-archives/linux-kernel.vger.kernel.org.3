Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA0B4C3FAB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 08:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238315AbiBYH4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 02:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiBYH41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 02:56:27 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18B01B3A79;
        Thu, 24 Feb 2022 23:55:56 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21P4dJVX030077;
        Fri, 25 Feb 2022 07:55:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=xAL5cQfWxG+AsyFisHH44k+Jpxpln0pF5Los8/HB8Gc=;
 b=wuo7QclwzuG8421RP66f7T3kDC9VWuLZkD6s3QTcGws5+K7HcyQZjH0D+qxmkNEW8Ghz
 sWJdPUFmtpRyNKTtfEFRaaQdzlxabFTSUkxb0qFTtaxqTJBHiQUABtbgexiqEgeKIJEW
 2w18zmC/JeCiMp17Y/7fZtCcV9kJAjLTgI2eXyoP46eUGXGbkHNWgBv0zqvMyvde2bqM
 F/XXP4gJTmqExknNG5o7ohMA7y5kuyn9C+Z70J91Bp1ajTEUNGwMPffaNMYaAmXLCbu9
 7ztLfWE9d4YXjmfWv6w5XVzg9J80TkJVkuQbyUq7oIr+ION3qiTMkNrMQWHBfamBfcPw 2A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ect7asgs2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 07:55:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21P7pEP0095176;
        Fri, 25 Feb 2022 07:55:45 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by userp3020.oracle.com with ESMTP id 3eat0rr5h7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 07:55:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OM2PrIiV795l7Mc6M63OfSWwIYJrfogQtCmGnA695I1/HwJq59QSYJnRMZUPITb/cbknGYeoh0FRYjkXcm7l5+xrM0zlp0NquEdpAleZ1wk+i/zS1pEwMl8d5ixPK5taDO7+0WfOXq5nbi3qC3MdleS9Y9+rnOj4Klo/RMmvvu+85QmVb2nhJ8s68l8tTo9353ZEjD9sjsrgNQ4MF43U3excTxzbnsgfZFQ58/vGjr9VRqqzL+LLCDe5kxlVUhh5alHog5nXy2RvOFYdAFJWutiU9w1mnR54/luUVV9PWA0FtU2uL7sh5TL21Kz9yYZJTNhy904VC3FdGI0be+47OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAL5cQfWxG+AsyFisHH44k+Jpxpln0pF5Los8/HB8Gc=;
 b=VRqN53NlO9I5pH6fQyFjnhfFgFVXBbYSHJ2XJQAbfXhU/lxZsFbtnRctbrSlneUdPeTJ/6veviKRrxJ+lXVcLWQPRH8RSAzUBzzA8/QzIjI2hcql8t0qa+oM5wxjb/CpzlysQBFV0BEatUClMmYO+6GWmAu84z9t/7bhFPZ1B/sSc5kP9fWtgkkWtWzmhhTUmk/zGjCgbo7unxnoMStwkg6CwpBKFpo6XjKIMMz8rpZ1i+XXjIOAiFmNiE79LEOInn+1QwIrGjGVuDWrGpckmJRqVOq96ByTs0NVlpMRTnM0mH778x0tmBwqdSmHuKTU7zEOS3dAnPWvoYISc9197Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAL5cQfWxG+AsyFisHH44k+Jpxpln0pF5Los8/HB8Gc=;
 b=LdWl8N8BrKx0vVln027fJlQPRZi7ZKQOzuULfiny+o/5RQmiqGani7WvA5rqtG3aZrEbhE9lW8YoHmyrVHPgFI0KR4o/MzNH5kaX0TKx58cpkXbtCtAaiq/FCUx3bP4oeDsQqCy3BCVixT9bBJwywVlZKxQXwXTgSnzqhp1dJJg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB4085.namprd10.prod.outlook.com
 (2603:10b6:a03:11f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Fri, 25 Feb
 2022 07:55:42 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.4995.029; Fri, 25 Feb 2022
 07:55:42 +0000
Date:   Fri, 25 Feb 2022 10:55:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Markuss Broks <markuss.broks@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/2] Input: add Imagis touchscreen driver
Message-ID: <202202250109.qr1l07ts-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222203414.8656-3-markuss.broks@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: CT2P275CA0039.ZAFP275.PROD.OUTLOOK.COM
 (2603:1086:100:a::27) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e8fbc57-ad40-408b-4dc5-08d9f834386a
X-MS-TrafficTypeDiagnostic: BYAPR10MB4085:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB40854FF18CA8F0BAC065ACA38E3E9@BYAPR10MB4085.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g2IZPw70wIC47VF2peLan1rwhltnUHeseSKmATOu5JQlpxMF9jYUs5rkMA23Md/Q4G0wolDzpKV1i7uLCFBFfnawAczeTbRFJnFbmf5SyejuBMheGUg9cQ4bPW+i4TI+kz6SqnhOPoVGA/SPAeM/Tdb7Oo/8NqJ8FDbll2sZXEAeg2oi2qCTUMUnF8zA50SB5iRJXStxpTyQnDG83MNXOZLz1uVEST8BbFmtVC/WlJIIz9s6T3c9WxAHDmsiqsi55W0FQDoM/zJHi+5lTD+NlBmS7NTgj+GLF00Ajbl95ekGI72VjNHUf53qYwPrg8DH1fiXpVuuTRE8hrdcQUZf8Cdil+zMMP9Tx901Ndiocu0uBUc1G5i6pkFU8Padr2J+ZV8DDDktjQii2p5k6NGCty5KOrdKX4NPfSrjLrJq/nDp1ItrWqM+SifpdnNHcigDavJcfSQNjc0ILZ/fOw5ZzVgFJWD30NmL1qJ0nnMipp3djR2YHMzrfpJaQRrgUSS+4IqgtvVfgVnTnW0AaxbwjtG/OXJ/rO9ImvazUMEOsyGKvOTbXeBw19DoKj8ARi8G6UuMTw+jLcy7BYhY3iKfQkg24Sp2fsh4q3h0c7lMZOzGHIMrJxPbotR9zClN0/d1FPayzWR/9LUFTdiJP+XVUv7Wdyqny8aXbrxWUy+/IwX6kByLJXslC7U2N6QTReqfUoDmYEMnJdMbYuwJbkgI2EFUFu603zUpeYlbgG8AGFc4PZWY+JvUosX1Od0zSWKhF6XR8r4UUI9S46sMlY8BWDRpsSFdAsHFWlnFGrfazcfnKU+PSjCqutfrmPpVhA9QIrfgc1hpKbmQXyGVuMXKhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(966005)(6486002)(186003)(54906003)(508600001)(6512007)(66946007)(66476007)(66556008)(2906002)(4326008)(316002)(5660300002)(9686003)(8676002)(7416002)(83380400001)(86362001)(36756003)(1076003)(6666004)(38100700002)(38350700002)(6506007)(52116002)(44832011)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?twq+epBM5TqQiyMZImOm9eWHq6eSUdJM9bjym95aeExIQwrIC2flGHexEbci?=
 =?us-ascii?Q?6lFoZpwSZ3VWVHfpB8uWq3U7TZ0LjxeZXyjBEsK+7S55jjBd9S/MLHtjHCkU?=
 =?us-ascii?Q?InSvetPt4331qEBG7AHZLmNY4PxCfO98HNHIVIGMXBLbORYeEbHmrRbrQocs?=
 =?us-ascii?Q?D6WcXi2HpFTV/ZvogvpK26tni6VkjawXcqM8A0SEUgK8WixOoP7tkWX8TVUn?=
 =?us-ascii?Q?SH5rGD3fb6gAtI2428xNjBsRckWYMsottVq5Jgnhb3oYBgC44xd6TLOkZYI9?=
 =?us-ascii?Q?WIYi6pauAorZWduQXXhAtWz1rnQnRtQ/FESTgtfe/oJdoOgUuHVjrYl/sZYx?=
 =?us-ascii?Q?h/9GmqIHVHzXQOl2bKhm1lrjxEj3AyCgEooj5HJGzsaw8n0oGpUKn4txXJHM?=
 =?us-ascii?Q?dTXmdL5ItOVq+z70f0OMhiYW68SIVVOrlyaY9xEsVV6mxuhV9O8YP+RURPCJ?=
 =?us-ascii?Q?1KgvaS3ZouvkP+9DWSe/QUtf8II5IoVfxIrzjtbZvGk1PmwFbRUkr4niYhQb?=
 =?us-ascii?Q?i82ESYTNevc+i0T8g7qr137z3uhnzsGTCTqFHuAmmBmgyN0iE0QQsp8puOaF?=
 =?us-ascii?Q?L3pTcb2CbTUfc5pKEgxMp7AkqitjHOI9TGb43UcDnprsJE49SiIfg3nLl4OK?=
 =?us-ascii?Q?4pI4M5D23QKkJcsJVjD2aXmRQ0yiJ4kgV+sifz3lfy8zQ5/EBD1E+PnuYSST?=
 =?us-ascii?Q?ser+/3vlUUvCJsi6gmfmsElZ8vRvJsCFLWn57QM87m9VYmA4aV3o6TFID1Uy?=
 =?us-ascii?Q?YKw7sxzTogxAW8MXBBPQQI8oYkLrRiUWZer9bjvfYQhqr4hl54Gd3BPDl08O?=
 =?us-ascii?Q?n9VtuEsJDB0LOoWMjGZydVJWjsaDlRwBvqqCIb3ceopkqDQHIIoWf/K/aIgD?=
 =?us-ascii?Q?2fGiges5cfDXLSqLm7ivHY1EVJ4dTxGDKAgIOaixztTg85fdESoUc7iM+SLe?=
 =?us-ascii?Q?Dv9zpEyC0iD6fMP9hP3g2hfJFSroiBuQS0tzqY+Gx/z8gVJ/CNxsSXvh/m/c?=
 =?us-ascii?Q?cZbYQkPhh3RPFUUHCdkf5kREuHM+pkKu/EKPEiKcVnQm0OuUCdo3A19G1xf1?=
 =?us-ascii?Q?kZ1PQWkblK/ofoQ/zrtf5Yb8fVEMEgrUeLH9RoFc4NcauG5xyd4kSEywQyk7?=
 =?us-ascii?Q?OLaqZoMqMP3Lo3B0FYbBDLPr9F1XyOOk+VJJI+A0D2+RoM+kdbVADk5vx2Mg?=
 =?us-ascii?Q?qqAZ02G97ATQkayrjPeiCggBORkWSQHMAw25gd45mZLIPgvYf/t6zfP8rUX/?=
 =?us-ascii?Q?yzgnsiXEziH2PkUjHEH5ow0Cso3R01+JGZq7PkrMCH5wFiki6KVwddTptTBB?=
 =?us-ascii?Q?7FfxJLcsrFVyCumYSfnKNeFdWK6Pii0qAqRxqABJNWSE3a7hOXjrib4mAvIm?=
 =?us-ascii?Q?oQ9+0ObrvpyoNzNP8BjEGx30MrcgAvuggyfBZ3jCvtxDDD/Cbkp727Ps46Lh?=
 =?us-ascii?Q?x8mrsX6BXbU5nKv99jw/I3hgiSE8UZ7HFfRd/96VZ6ZSN0snZv+w16W8gVu6?=
 =?us-ascii?Q?88QEI/QF4qCSJRXKJdAYpWg8QpkxzBxCXK9iehxO+q3E7sE87UCWD/L0KFGL?=
 =?us-ascii?Q?TQxt6bVxwUd5yLfQ3Ogoj4Gj2AjVeIvFNSlxc8YwDzzeaXDlM6rruOc0Rv4S?=
 =?us-ascii?Q?PMMLkva4hM+yXidFRLMp+iPyK3BYV6lwWy8gVnAJqQI2qI21ycecwoYNEyb2?=
 =?us-ascii?Q?NF5BwA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e8fbc57-ad40-408b-4dc5-08d9f834386a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 07:55:42.1707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JuwJJXeN2KQ9F66cqMMvQtVaCXDtmfWkp/4TAHKCMPZCmVEtUCm0HJ2z9EAf6fGTUf6ad319DaUHcWZFbB+PsE64PHUv4SVVqWO9+vBXKA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB4085
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10268 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202250039
X-Proofpoint-GUID: 8hywm7EdZCDQViQWS0TG-HiLJhKipEHt
X-Proofpoint-ORIG-GUID: 8hywm7EdZCDQViQWS0TG-HiLJhKipEHt
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markuss,

url:    https://github.com/0day-ci/linux/commits/Markuss-Broks/Add-support-for-Imagis-touchscreens/20220223-043645
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
config: microblaze-randconfig-m031-20220224 (https://download.01.org/0day-ci/archive/20220225/202202250109.qr1l07ts-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/input/touchscreen/imagis.c:305 imagis_suspend() error: uninitialized symbol 'ret'.
drivers/input/touchscreen/imagis.c:321 imagis_resume() error: uninitialized symbol 'ret'.

vim +/ret +305 drivers/input/touchscreen/imagis.c

bc77ee5e0d7309 Markuss Broks 2022-02-22  292  static int __maybe_unused imagis_suspend(struct device *dev)
bc77ee5e0d7309 Markuss Broks 2022-02-22  293  {
bc77ee5e0d7309 Markuss Broks 2022-02-22  294  	struct i2c_client *client = to_i2c_client(dev);
bc77ee5e0d7309 Markuss Broks 2022-02-22  295  	struct imagis_ts *ts = i2c_get_clientdata(client);
bc77ee5e0d7309 Markuss Broks 2022-02-22  296  	int ret;
bc77ee5e0d7309 Markuss Broks 2022-02-22  297  
bc77ee5e0d7309 Markuss Broks 2022-02-22  298  	mutex_lock(&ts->input_dev->mutex);
bc77ee5e0d7309 Markuss Broks 2022-02-22  299  
bc77ee5e0d7309 Markuss Broks 2022-02-22  300  	if (input_device_enabled(ts->input_dev))
bc77ee5e0d7309 Markuss Broks 2022-02-22  301  		ret = imagis_stop(ts);

"ret" not initialized on else path.

bc77ee5e0d7309 Markuss Broks 2022-02-22  302  
bc77ee5e0d7309 Markuss Broks 2022-02-22  303  	mutex_unlock(&ts->input_dev->mutex);
bc77ee5e0d7309 Markuss Broks 2022-02-22  304  
bc77ee5e0d7309 Markuss Broks 2022-02-22 @305  	return ret;
bc77ee5e0d7309 Markuss Broks 2022-02-22  306  }
bc77ee5e0d7309 Markuss Broks 2022-02-22  307  
bc77ee5e0d7309 Markuss Broks 2022-02-22  308  static int __maybe_unused imagis_resume(struct device *dev)
bc77ee5e0d7309 Markuss Broks 2022-02-22  309  {
bc77ee5e0d7309 Markuss Broks 2022-02-22  310  	struct i2c_client *client = to_i2c_client(dev);
bc77ee5e0d7309 Markuss Broks 2022-02-22  311  	struct imagis_ts *ts = i2c_get_clientdata(client);
bc77ee5e0d7309 Markuss Broks 2022-02-22  312  	int ret;
bc77ee5e0d7309 Markuss Broks 2022-02-22  313  
bc77ee5e0d7309 Markuss Broks 2022-02-22  314  	mutex_lock(&ts->input_dev->mutex);
bc77ee5e0d7309 Markuss Broks 2022-02-22  315  
bc77ee5e0d7309 Markuss Broks 2022-02-22  316  	if (input_device_enabled(ts->input_dev))
bc77ee5e0d7309 Markuss Broks 2022-02-22  317  		ret = imagis_start(ts);

same.

bc77ee5e0d7309 Markuss Broks 2022-02-22  318  
bc77ee5e0d7309 Markuss Broks 2022-02-22  319  	mutex_unlock(&ts->input_dev->mutex);
bc77ee5e0d7309 Markuss Broks 2022-02-22  320  
bc77ee5e0d7309 Markuss Broks 2022-02-22 @321  	return ret;
bc77ee5e0d7309 Markuss Broks 2022-02-22  322  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


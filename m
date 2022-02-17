Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448474BA10B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240915AbiBQNYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:24:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240597AbiBQNYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:24:40 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F80D3AEB;
        Thu, 17 Feb 2022 05:24:26 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21HBOBs6021455;
        Thu, 17 Feb 2022 13:24:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=4XwWi/6r4TVRkfQopBnDlrI4GX+cUUnBCvfDnYg99Mo=;
 b=EMMNH2zmLnkadZeBkhMgNz5G2dnwh1y2ntxY9dWmSa8JiW6dUQUNl0Glo7su8Kx3Vi2w
 2t18J6wpehPCnw7bo59QVxtRio13Ogbo/vlJRc4a30TRqCOZ6WqR1qXmoOpNDw8P6nLw
 g+k6r9ypLGtoSw5IMQpxmMVS39Gl4AF8GZY52dWTpg4FjR+92c/FD2vn7y8/+g8S/L7h
 rXaMGNfq98mQcBkXL6c+PF/sV1hVwjOhs2FEKxI5p9fQFwMP4K8UnRFV67abKv2WkC0D
 BkFej+VhiD28Q1xGn0eq8E/YiZqNSCVkuU6RmmSzOihaH6ip0335w/lR5msoKX6pP30s 2g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8n3fdd09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Feb 2022 13:24:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21HDCGkv157356;
        Thu, 17 Feb 2022 13:24:17 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by aserp3020.oracle.com with ESMTP id 3e8nvtuuqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Feb 2022 13:24:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YB/xhKjjct3cTPKUWHbsEcneNmnW7hd80tkR3SFh2AEYOeR4zKd4EKWCFjrEYXIaB2+2ktMnIaT5rwSPn/JoHzKYFwrHMIeHdIeGqFj0Yco4A4oJ19Ui51bY8ni0/174X8lNPOXMqcrjFEQKkPvOSFYOhC8qddjlQMbX9Kqo5b94iaC1nPSUsGDyeKc74Ziw3yelkV/Fhq1npIWeJpMVf1a2bWqrpCKITwTH3pflhtWg19ksfJdDcrQ44GxUrg+x9eV03xqz2vWkL//swut9eHL6jLh7tOZybqY9UCAe535oqmwCGq6o38GiaI76eZhFCqL9RygRUXre4SVaUD+8kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XwWi/6r4TVRkfQopBnDlrI4GX+cUUnBCvfDnYg99Mo=;
 b=lBdz46q3nt5Oqe7P5fXcTd6B0D6vF3MGXPhHn3IB72nS3KA1zP1w53WnQhcZiI+nWrZ0g3urwfMiDF+mu8OWlK+ycEav9D8m/I7Tor7ZVkPlBOy486mb3F3Unx1B5DkEFpcIJSwGJCRG+2j5rVZcf76zdSTbjQR3Iqn56XHwfZuyGLKX+N2zhU3IAe4Qf3B8/yNoHrwI7o3CgB45gwHAkuS5ZZF2HLKm0+zqlQZH9ChwwmZYwpghVVLo1rJ5bkkrgdky1QKcQpVHwyRw7MM8uVACl063o36qHhLsLUf+eY235kJf1gGA9hycm1tZ3JgxKpi4dpleURqp1hokXqtx7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XwWi/6r4TVRkfQopBnDlrI4GX+cUUnBCvfDnYg99Mo=;
 b=WBjJIz0KEJxgE1uTmAkF9kCbzTrkEXYvtnJ7kbYSVIRN2lpLfAp1FrL53iiWbQxRfRG1DPplANLr8W1ZzugIHdFRlQ4C3l+JoLcAccxNMQGxfM92ocf8bkwQ4J2c0qkmD93pUrlVsB22/Gx3dqxAbj9kQrN1r6Dj0zVfo6CNvoA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB5466.namprd10.prod.outlook.com
 (2603:10b6:510:e2::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Thu, 17 Feb
 2022 13:24:14 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%3]) with mapi id 15.20.4975.019; Thu, 17 Feb 2022
 13:24:13 +0000
Date:   Thu, 17 Feb 2022 16:23:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kbuild@lists.01.org, Jiri Slaby <jirislaby@kernel.org>,
        lkp@intel.com, kbuild-all@lists.01.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mike Skoog <mskoog@endruntechnologies.com>,
        Mike Korreng <mkorreng@endruntechnologies.com>,
        info@endruntechnologies.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] serial: 8250: Add proper clock handling for
 OxSemi PCIe devices
Message-ID: <20220217132352.GC2467@kadam>
References: <202202130027.ZKBCgtm5-lkp@intel.com>
 <alpine.DEB.2.21.2202171009440.34636@angie.orcam.me.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2202171009440.34636@angie.orcam.me.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0001.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6f9cf05-1a6d-455b-8b24-08d9f218c9a6
X-MS-TrafficTypeDiagnostic: PH0PR10MB5466:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB5466E7FB5D5EA2792507414F8E369@PH0PR10MB5466.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: szQputNnfo9YaWmftRkbmqeq/QvTTcsg43WhXNEWi025Y95TJWhuryxjpUrBAeMs8PndxQ/KfK6qXJ+0QTd9TmfDu5pZi+zRsvLy8j7U+xAm0FMsZ640omgv+eqJhs9JoL80RiPgN7YFbg83ACV8nAvtS0tLeusK3ZQulNkQ/cV/ChtCUCCED5nX30SHSnBAS72oTwDSa9/eLPH8AdEdg81Y0Q/uw+wOcdxkAN0mbaSnIZ3/wQhNO+xzlJr1p3FXRDJka3T9cPzdgsWt01RJZ9tk+XQNRzeHDOeOoZ96Zjo9JG1ACo+qLlKuBfe7/8qY8IjgK4/JHLRCCcxGTijZ89DInBfMDUku4l9yFzb0w4lEEclMRZZmYVwika7VQ60MgVQAY2dpEcK4bu6l6P9jovdIPKN7uejlAsjvL8zUSXk8yXJpMAf3SbZyDFPWfZUU6NZzCzicux6V3yXLIdBX6Jfik/nEjmGCsBGCJpF5BSZbrahTx1chN4DG6NEyKdglJMv4nboR58qmMT7Wz/Z30l0AMOnxnTLJyOLcXDYtGNMcsH2T5B0zTP6XVdSa+YX0NTUWdwQHzY5s0vUXQe6wUmNxZgynyFEzMHzThQBA0KAv3TfOUnYt9uLrdDG9IJW/cy32jQEX9/v12sFpqhbgD+/cM7t+S18C8Vqp8ULCBhgaic/oYh8a550jfyuwFQxcpDXy6JbXPIUo5zN7/k92tfYrbfmHwEPpcJ8Yq1SWlmS6x9ZkCeH+jtECMLM5h4hdr1yGSoayZrRgInmq2yqP+4upOBcPeIeFX4BI+rANrz61l7MfZVGqBSRCoHi538OTu1XjRnTNcsuYWbkclfyxtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(6029001)(7916004)(366004)(7416002)(52116002)(6506007)(83380400001)(2906002)(5660300002)(508600001)(6486002)(6666004)(966005)(44832011)(86362001)(4326008)(38100700002)(38350700002)(8676002)(66476007)(66556008)(66946007)(8936002)(54906003)(33716001)(1076003)(6916009)(186003)(26005)(33656002)(6512007)(316002)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oi0FxpSHjEkuXoka2pvV6htIsMY9YXE+RGcUmaQB0hPT5pGI6IXGvwSyadtF?=
 =?us-ascii?Q?QCRCtUt7ts1DYWq3ECXi02pDhfrPqpl6JEgivbOLALInSmMlsLPxtBpu681F?=
 =?us-ascii?Q?YWtczq8Kk2oGfTiqk3KnuxSmsZNdjftt/7FvDfBKa66BeRGkeRMAmOv1KEim?=
 =?us-ascii?Q?Pd9Lyby+ZX9nV8amrIf7c7cZ5UoUQir4lwj1YoYfB+wTBYSQu7HzvDGeMit+?=
 =?us-ascii?Q?3KYyhSvdqBl8jFx+3xT/FJ1gVKjefP7JAi1bRZgyADZ5bVEw4mA7Y86k2P2A?=
 =?us-ascii?Q?/vHpUF3tSsLhOo5vRvs7dvqI+I/ZdEe0OdrFrzcmXaeCA4UmAvHSCCW1i6pn?=
 =?us-ascii?Q?UkF49q2DCvTVmp4OMiIXBqwDqQ/v5NAQrzxfw16xbjlxE3v0M0IMUtg4OZeM?=
 =?us-ascii?Q?CBNIPbkwZMrItj4oEsPWXBQU/A8BfESAy1jkC4kqCHJmHnSyL/g9kktKfv1I?=
 =?us-ascii?Q?pFsEXHlYoRwB5Y++VnLQPtmqK6gadPBMwlHhve+5zwCjpwLoO8h6I6Zbg4Ko?=
 =?us-ascii?Q?w0DUf0hddAWXWaWS3TP4Z93WRrHcRr2V7g+B0n5PKl0qYJSu9EQTGQqTJx76?=
 =?us-ascii?Q?MwZz6zZgBSZa+f4JW457/ksCnCzcFG7MW003N+xp49Ry01X/cPhDzyMekUAf?=
 =?us-ascii?Q?Gc6m0u2G4uf+wH7AkTLia1S5zuPwyKNHk+UMYc6ZzgupbLiExAUVFuJ7PkSW?=
 =?us-ascii?Q?pMskDTNX32uo0lfnc41EyeEgZla4sq3D+LPjxrUPodGWmPg13AQqrBVC3+eX?=
 =?us-ascii?Q?AQrHrUEvs2KbaKDGl4RwNWjG7BZEl/ThiaRXpjgZHSaSJV5vF0G++HBABJpN?=
 =?us-ascii?Q?6yA3KSCttfgyEFU0PR2HqBL7fLjIK6t8TO4fhpU1/6DXcHptAeUcQlnf7zrk?=
 =?us-ascii?Q?yj3IXWen4hHeyEVi3q6cyyzpDzymb6A6h5q4Cnd0tbxRdf0lKcZx0/Gi4pKM?=
 =?us-ascii?Q?vxDAujV5SmnwT0T7IiQcDtyipcwVQuvomfb1CNMDQe3dWTGTQAaqIHnCEonN?=
 =?us-ascii?Q?jU9hSUixQwCwM4XKhGb5Y8dQZY1iArslEZw/a7K0c5WGJGzTUkZ6H10+jl8W?=
 =?us-ascii?Q?Ot2fVBBKLBvKF58pnoH23Sf7HWa7S73AvENv6tOeYEonO6K9SOOCqxPwC6fO?=
 =?us-ascii?Q?rYtAg7/Iuz853mXJAc3B03ROjim2dtv0AXhlxSupI3EggVzNbf6+aEJFByJl?=
 =?us-ascii?Q?56xurIuSuMEPXL45Em/Ma3hjo+EkekvK98nte8pxmcWh6mESEZq9aZLmIAh9?=
 =?us-ascii?Q?YX4lElHCivC4b/akwnDhvcWzVZZ6WCspplVK85Jjkon5+hsKpZhByGhUyKL1?=
 =?us-ascii?Q?TUuwcTHpP1lxKVYdsxAtl2fvBsZkPMVkCQwQ3IAZ4dgadNMF52VmqNSJITGE?=
 =?us-ascii?Q?dRZiARF4pEWjBOkjhUNjInCYLaEdpTazVuqlHA87h9A5ad8aT4wTuK88+SUe?=
 =?us-ascii?Q?upYB6pkm7r4Haa9wQS6cyCNZ63UqEIeu702bgKTKKwl5vxzi4O7IoYycuhpo?=
 =?us-ascii?Q?gCft3CulrLpaopD0UyONiEhQhjOPWXTV3NUUFlYjI5BzVViziiA8mpfoIySC?=
 =?us-ascii?Q?jNdvfSgHKq/3sS9+PRuJjwU0D2VRk7wguyQ9lUslRNxGfZ1Xw1Xz7jPP1wA2?=
 =?us-ascii?Q?4sAnjOcAfvbqSs1Q1fLldTgw1V93LWFU+2PkiuJx8Ia76m7g5oVQOQBg9jnj?=
 =?us-ascii?Q?hiKFeQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f9cf05-1a6d-455b-8b24-08d9f218c9a6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 13:24:13.8406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zgVoiocbqkirlaUt0Yl1LLat9c+emHXFIcSFeDNsaR//bskSlZM/RLDz2WyZQkWNY/xaZJZyMxPt3etBLMih8tmB8p9cDZ0wBp26/PmHmb0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5466
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10260 signatures=675971
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202170060
X-Proofpoint-GUID: 69Bm3NKNMVMF4j0S4dhR6BMDR_r0dJci
X-Proofpoint-ORIG-GUID: 69Bm3NKNMVMF4j0S4dhR6BMDR_r0dJci
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 12:05:58PM +0000, Maciej W. Rozycki wrote:
> On Thu, 17 Feb 2022, Dan Carpenter wrote:
> 
> > url:    https://github.com/0day-ci/linux/commits/Maciej-W-Rozycki/serial-8250-Fixes-for-Oxford-Semiconductor-950-UARTs/20220212-164255 
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git  tty-testing
> > config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20220213/202202130027.ZKBCgtm5-lkp@intel.com/config )
> > compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > New smatch warnings:
> > drivers/tty/serial/8250/8250_pci.c:1171 pci_oxsemi_tornado_get_divisor() error: uninitialized symbol 'tcr'.
> > drivers/tty/serial/8250/8250_pci.c:1172 pci_oxsemi_tornado_get_divisor() error: uninitialized symbol 'quot'.
> > drivers/tty/serial/8250/8250_pci.c:1180 pci_oxsemi_tornado_get_divisor() error: uninitialized symbol 'cpr'.
> 
>  These variables do get assigned to in the first iteration of the loop, 
> because the deviation calculated (`srem') is normalised to the range of 
> [0,spre/2] and that divided by the original divisor (`spre') always works 
> out at within [0,0.5], so `squot' will be within [0,32768].  I guess the 
> static analyser is too dumb to figure it out, so I'll see how to paper it 
> over unless someone has a better proposal.

These emails are a one time email so it's okay to ignore them if you
want.

regards,
dan carpenter


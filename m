Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734BF58CDA1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 20:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbiHHSa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 14:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243937AbiHHSaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 14:30:52 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1991263A1
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 11:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659983452; x=1691519452;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CZgu/DeJZ5CbzzV5Bd8w1PRBEOOzGRoUQErjPe3rzHw=;
  b=NLaUyFXNxFfewmuWpZ0nvfCy7QCS3iFp6v4QsMICebaZiWzmub7mWGrE
   yBMLL9dNdKcyaS0D1NiJnTXTQI4MqQWWEpnPtUwhWLB2NrWa6QXboZsXp
   mKDO/TDQiGhv6O8oK6jo5vR26M4I1BXKHA7CX2UA57QRR5y0MUNK8N8fu
   D4vnoZA8dT6HZ5m6MRLlNPdRAqSB0faaC8GsZgtjIlcICdq4QnEbNkrTI
   WauYr34E7s7HxLIbp0Gq2sM3kElw+iE3gNpMFemB/X2fjIJ5RapuziDzy
   cQomhQNlixkB4d5KRjaEs/S8+8Y8dI0JnI6GS5EjnKkgBBm/i+x2v7RWB
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="291443733"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="291443733"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 11:30:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="664076407"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 08 Aug 2022 11:30:40 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 8 Aug 2022 11:30:40 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 8 Aug 2022 11:30:39 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 8 Aug 2022 11:30:39 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 8 Aug 2022 11:30:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGiVZ+uP68g9P7/I6z7meU51S870ykP5pDZpZi6duKAJCLyc1D5ZXhmPvvwD0hZk5OTR3FJEI5kSrM58ixZqaHWHKnugIcUgdIUMcGkOJ+5djNJBox1M7gMgzMWyUC4xIFQSchzWOyFJTNSCj+4gognhFk0Zuwpxm+Bc9KK2VXjKOcMaxpwEQTdODwGeiWkbbdmNGuSTF+9DEdaaKfpsow3aRm1/1rrUhHp2CocwT68rfBW8gEMPwAe1SKurxxvFBBUBPffCmuE/DZsBXU9HeIqjEZl2cfRmOyIqhqffq2+bQhehPJb4S8Ohyr8zkxtw2RMvtB5VW8BbBVPaTdpvsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0p/et2QsQlWNcVW23yeJsk4Y3dpd1z9ViS2bSKjBHUg=;
 b=UqLDsN9SMnGSzXVC6yieey2mqxw7glQm4+eb9mAtyHwD5W9F49Bbabd/vI45N3v97KPrhKD02qzcne1Ks2vgAg4BylWOWLUoM9pp5h0OGXkjQxLCUL/ZSGA4SF9NBxw1Hh3HpBR9FgnGeAc9vzI1U78v8qxTywveFgNlBmoNzK1RaMHEYXKnHD1Jjyp/VjAWR9AXCxbKfOsh1Zmt4wFJn/SFcl2S+kmzpCiosuKYgUz4RNGMu+jb22BcO2vzvHAcljZTc3kEGDTzEN/EwkDZyd8vei2Z79q0BCxklcVzT0YY6ZULSQgmqgijfaRKu6G9zFZxcjCgjw1td/u2RUe0kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BN6PR11MB1378.namprd11.prod.outlook.com
 (2603:10b6:404:4a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Mon, 8 Aug
 2022 18:30:37 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 18:30:36 +0000
Date:   Mon, 8 Aug 2022 11:30:33 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        <linux-kernel@vger.kernel.org>, <pmladek@suse.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        <nvdimm@lists.linux.dev>
Subject: RE: [PATCH v5 24/32] tools/testing/nvdimm: Convert to printbuf
Message-ID: <62f15649dbce8_1b3c294d4@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220808024128.3219082-1-willy@infradead.org>
 <20220808024128.3219082-25-willy@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220808024128.3219082-25-willy@infradead.org>
X-ClientProxiedBy: BY5PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:a03:180::31) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04adee4a-153d-4dff-46c6-08da796c1645
X-MS-TrafficTypeDiagnostic: BN6PR11MB1378:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vo3DQ0XIUZ/9UK2u7jNGiVaJTNHGJyGzeQT/sza8fHrrEcOak5vKDXhHpFQDuRqB//dAY2fKyVvGyryKtWmODE/FC3EblVpjEaJ+D/LH0ILhcHSxYRYyS7atGx7qtGKMd1wOL/W5EJqGrNv5/hzrBnLBFNz67ireJihcW5P+HfEVcnnx6Zj5tnNAfHB/lbBmh8Anwj2N2s1CWWyNhBBY0IuVrSJTTzrxtrknrBl5qSRfDSr6xQzTQ2xGtGbfRsFdE/Ze8PRNDVgT5WV9tYoNG4/frDgV+BhvxY5ZBcJN2gDduud0EIseQ4oPdvwHbb5vu4XKB89F+yCrMHURUndi/yXvtzNm4Te7dTM0D4YZaJ+xhF4u26f5psq/dZdPDNTC5ST9OrX95fZPx/shTJJauYfMOVvGkPByO2+p24bBq1CZrLpbR+0eQzkx04Qyd3IAyVruS890LjKIuwAH/KboIUqnVsSgeuDD/3A1CGmDtAG7A/yLf6udlzB30zMfR4rLQGk239BLQwKedhxRB9g7QS1Hs+rQcA2mkW9qVfCEsBS2pyKvgaZeh5bwqpN35egTfiOJ1FBnkBc5r2F5ON6QA/kffLewhDBkc3S5ndtjzJGC7HbdBLlGCBdSZUf9eJygoKw/RT7aqGiX91GTSu2P5lrYN7PtTlJ1ML+zxLqWecj9+j/BZXlBVS7DgKhbTo+IMUx8+sOgH+dv130Nbw4nJ/of6HZbW+DRHbS+IeME3cYhKQNFNhhP20mTdJ7aleu92XmPUny+4uVWdxEU2d0BgLA6TQ/CSSASOiHbzonBXMxUEoQaQoGDIhBe0z3omMBA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(39860400002)(346002)(366004)(376002)(41300700001)(6512007)(82960400001)(86362001)(6506007)(26005)(6666004)(9686003)(38100700002)(186003)(8936002)(5660300002)(4744005)(66946007)(66556008)(2906002)(66476007)(4326008)(8676002)(316002)(110136005)(54906003)(6486002)(966005)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bi1HJYpCEZJcaQ3DbFpM/AV5WGBQ/kEj+UIEDkwfcA2Kb0LRQYLIT3RN+SyQ?=
 =?us-ascii?Q?U8OBHeVFoUTTXyrEGqEwVOeX51WeQbd36ofTGHvkXgt73MVQloYo+ZXkWElO?=
 =?us-ascii?Q?MLm2Y6Y6lVbCZ0JYZxO4xnaz9Skd5/57b7vKzqaAKmkCn5yTb5zRIJoLIWmM?=
 =?us-ascii?Q?ovThxCVgb3Xql0vqOH2JOhas3ovPnqIPFZiVUXMUAFVy4yjU3dbSYE3kW+nu?=
 =?us-ascii?Q?tYZsECHpUDILXoQY4gvUNlBgdwedujBQ03SwSo+y5kajC5qWgo3Q3xn3Gfb0?=
 =?us-ascii?Q?xMvaOXQD8ZykG7+fwVbf5l/8EIHj/lizNRZ/AB766M6DC5Ir7YLhCOr2InDL?=
 =?us-ascii?Q?dcpRIzb1CnlJ3ypS1HZp7oL2gnpYm39dOCHcM57ErfcO8q/sORzu6gZqX/ur?=
 =?us-ascii?Q?SPZ6d6oNwBCVhXBlKjgt7A/9Y7mfbLi+tCTAPI7BltnlipmZsIqbvUn0VWpm?=
 =?us-ascii?Q?9/q+5NkFQ20tmV2cD7MdKbhcTyMc8UgXJDMKcu+jQ6F7LSiCnnw19sileQbN?=
 =?us-ascii?Q?KFlSjng6q2b86Rj9LwzQwOxVpmY31qRZ0sE2iVEc1CCLQDM4OVPsTzz2TZ6m?=
 =?us-ascii?Q?HuhlFBiOpaJCczE6sFHkgJf8H7+nIbssFRvOp3+9OTmEFICSfcBYQ6Aym8yY?=
 =?us-ascii?Q?if2GTQcTfvED2jOpjBG1fOa96FbzgvVuJ7B/gPR6teDQ/NzLfsJfsSmpONR8?=
 =?us-ascii?Q?DFB/C04KNc9kV8YC8IFgFwbLgK1UriYAvhCb7D+Egie98K1VKau8It1NctGo?=
 =?us-ascii?Q?dPIHxXu6MszWffopzMwixWLpOHfMyIK+lAXjN5pm6XLjgt6AYspYe9fDAWcX?=
 =?us-ascii?Q?M6uOCJU7uuDeiuFw/WxMCy48QrmdYAhat4yDTYtKNw9GPQJSuzvtzvJtWskr?=
 =?us-ascii?Q?hsJPI9nOcfgImcm3ZctoKJhfxeSOKqUg4KJWLBdo+xWqrC092kclOvEWKEse?=
 =?us-ascii?Q?Rw2Kw92z3UGOr8Dqi4hqOovDpa8c2hFfujhN5H9vzrGfYoOh47gksFNXTaEK?=
 =?us-ascii?Q?wXKKx7eHX68KlyIx/rFRUshF9VVSFj3jiLarvX/tXKiBrEytERyCAXPIMK0u?=
 =?us-ascii?Q?H1sWN7v+Zr58y9mIRtoR9tDJqupfzYF4JfMmulr61pIUF0NBLfgoCJbRyDow?=
 =?us-ascii?Q?dL33exXAsbRQGiXchO6DT9W0M0fJnYhVm1ILGwUZ0gspehhPhOYLdz+oHQNX?=
 =?us-ascii?Q?RxLsyIPvcq7R0txf5Og90+/G2OVLm/kUExeNU0KDNN4sLrzmaeL50RaHDQ3r?=
 =?us-ascii?Q?0ByXmbpwyMYhQtgZBhqIgp9MdAT2r1jEFxNC8KgOvccgNV4IOzbUdWV/hbBZ?=
 =?us-ascii?Q?MLlIpub2lJ5MdSuuWifFTxO/FNAkL8Xr/s9j5rxtRGqZwjnTF7BgViH3hEc7?=
 =?us-ascii?Q?E2ikbALK7CER5sVSDNAiIjH6G3KAHekQ70nvq9FO90gPz85f8YaBY4mT9wLV?=
 =?us-ascii?Q?Hw2EkOqzL1bGaBHswwYD0pwg8cMU+suPk6bDsNo0TEfIkvosI8HFgmoZgw4v?=
 =?us-ascii?Q?id0iGs1+AqRYlYw85IpdDeX8Fay+7fMN6Czsk+Vgdyg8tzr8KbMC7SErn2Wd?=
 =?us-ascii?Q?1Uy2AXrAXU+ROUNpAbrbrfh3McG2Z8dpuNbnQZODCK4bzY6yMiz+9twD+5SO?=
 =?us-ascii?Q?mw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 04adee4a-153d-4dff-46c6-08da796c1645
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 18:30:36.4664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3pVnj40z/tMtijwfTHhzvxJ7cmJjLu0GyFoMaidFu/F4mXB7RhQQV9TYQclqz4fKK9eL1N+5O3Rl23dioie6WUtWC1QDAJP8q0tgJwZAHr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1378
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox (Oracle) wrote:
> From: Kent Overstreet <kent.overstreet@gmail.com>
> 
> This converts from seq_buf to printbuf. Here we're using printbuf with
> an external buffer, meaning it's a direct conversion.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: nvdimm@lists.linux.dev

My Acked-by still applies:

https://lore.kernel.org/all/62b61165348f4_a7a2f294d0@dwillia2-xfh.notmuch/

...and Shivaprasad's Tested-by should still apply:

https://lore.kernel.org/all/b299ebe2-88e5-c2bd-bad0-bef62d4acdfe@linux.ibm.com/

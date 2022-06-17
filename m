Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB4254FD80
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 21:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbiFQT1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 15:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiFQT1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 15:27:46 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881D71FCCC;
        Fri, 17 Jun 2022 12:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655494065; x=1687030065;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kD9T98S7GkjkZthivYxqYBBUCkNDdR/mQBrukF/wEaQ=;
  b=c+YfJyUiWT6cWOdzp534YlDdGfV/sGU3CP/99HSXYGuXxmEHwFdwDjXl
   9ma2KmSMxgwDghFvSBCYb9+gg9aXnux3FtECBjm+HHGGB+pRcGc6Wjt8z
   cFL4rzzWboEtFHHdo2LvGr3bEYPAoUhzcp/UfREs1THa+EHyNgn62B5AI
   lA1/ZBIevBkytq8ws6V8lwzB38b6F+bk/Qyniuw5BDWK/WsPQSy7AnIx/
   Ng+loUMFzhu73PsaJU76DcycmmRdqo7Q8s9aJv3A+sLONL19xHBzGJ6qy
   8RD6Pbw1n6SmHC0Ec2nsfM2Pq6A5vbp4g2hGXIBxLg9M+ElGN44ZXK9+c
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="341254473"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="341254473"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 12:27:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="688432733"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga002.fm.intel.com with ESMTP; 17 Jun 2022 12:27:44 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 17 Jun 2022 12:27:44 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 17 Jun 2022 12:27:43 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 17 Jun 2022 12:27:43 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 17 Jun 2022 12:27:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YF0b9Mapkxk1lKde1e6C04fF50d9ux+VOE6puI6vK55GBGMN+ZI8j/+P2W+sLHHCllPtWfTceYSYDeCvYU2PmwmFCmU4R4mDyva1rQsx79SkaWB7Ebrjf2BmvZmWaWmiibg8H7Fm/+eiaCDbKN3IW8ZJ1cEDuPWdZ6YmuVFsFWhGwrNcca9RMZ79JiRf+QV3MkbcxcSN1zdy5H7XDSQx61//JvxaYYDPc7MdtT401P2xbdhKALzsXq6d3/B3UToc6Rhy12wAzfxbJBRysKAkzR13ipqOveDq15A3TOyhN2rPJXcoLvxAfet5xUeRh4fjf1xyg+flaa0hbQIfyPKfJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQkTiAqaN4p+sYmdWAA0WF5gklolYkRmuodA8JTBz/4=;
 b=FZqML6BVJ0mSLgykDe1blOaro+5BdoIOyhR3F5nRs4Ij8O36NYNoWFHw0QytM1WBtSpfi03azwdIqqd/aqTKGFe2C0o2UgVZyG3H7a/EhF7sgjt8v70pOu/6HlvOqN5dpjn/CUVkduaKhQkWSaqdnW9aMTG36NR+mCmgZPCrC5yBRQyhqUA+SA5U/2p9Vg1vLdAzMTpw1uSZIrNp+8gUeEwa1GucWMFXu1pThVVvDURtgATCvP/2ZvYoOjbIEO4N7IDWBae4zNfIRyu/xcYmpwDbRD6TzOS/Y/BV9jVcnh3frqaLvfOLuiYzQRMs54iiM+TCsj+sIhASbQfyZ7aO9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BN9PR11MB5289.namprd11.prod.outlook.com
 (2603:10b6:408:136::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Fri, 17 Jun
 2022 19:27:41 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5332.023; Fri, 17 Jun 2022
 19:27:40 +0000
Date:   Fri, 17 Jun 2022 12:27:38 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] cxl/mbox: Add GET_POISON_LIST mailbox command support
Message-ID: <62acd5aa94391_844b129490@dwillia2-xfh.notmuch>
References: <cover.1655250669.git.alison.schofield@intel.com>
 <382a9c35ef43e89db85670637d88371f9197b7a2.1655250669.git.alison.schofield@intel.com>
 <20220617150508.0000266a@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220617150508.0000266a@Huawei.com>
X-ClientProxiedBy: MW4PR03CA0103.namprd03.prod.outlook.com
 (2603:10b6:303:b7::18) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09ddb08b-9c06-4672-76c6-08da509771bd
X-MS-TrafficTypeDiagnostic: BN9PR11MB5289:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN9PR11MB52892FC317ADA492A0483443C6AF9@BN9PR11MB5289.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: honSdZ5qWYtPFnAd3KwqyM4kHgBTOF1XuIRBf5sH1SZJBs2ELQvkgsMJ33BgXSbSwpZ34mS+C2CYZjYQR6Yu8+Bvqh4y0RvHPmfiZzscZ652lqHn2xWYDwgbTE4rwEGm96jLJM7Bn9g1dWHFmZ+Zrqkx/h6B7DkY7HQZGNUnogq5XgdaInQ+NQ2EksK0FefGw3AnMj7qt7oMa4tBVCqobP96bvz4yJKq3fvGzGo2OXL3iYTW+1JX7Z/yGw8rnHtmGv+4rKKqcA6o2pujm643H2fg3E1vHzQNyPXSt9aEh38TTyO1Cor+n6bN0qPWMJ7SlCPWnmk4HXX0dSI43dBuHlJgrKtFqtllQcdKP7yH9JSj5FiB+reMaJ57sbK+OIm75GQFimJG6vImU5omOz+PE9qJ/rYMiRXs7ipTlCgeCCQfyujcH4sG5HAUc8qPVnnn2PGeS877uZBwaGbUMoE+KtEfY8GFDKmxVRcVqq3nDhs39qLgdqzt5z9MqSe9BsEkMLpShKCrS24PU6soFIuu0hI3TP7HzEYv34HjNq6EishBifbLFZOXdwdwls9J+Yr5wJSBnRgYUVSIpswKou9ToFOfAr+tPrjyR3eKrsf6BUcTzJamAeFYni1Depym85YrRxbnoGry/wZ1cwYlkQ2vTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(6636002)(186003)(498600001)(82960400001)(8676002)(66556008)(5660300002)(9686003)(54906003)(6506007)(26005)(66946007)(83380400001)(4326008)(6512007)(38100700002)(2906002)(6486002)(86362001)(316002)(66476007)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zTRc/OX1j1tvsXcdMSc0QFEaPQEXg8fn6WjMCP/5nK2A0k6/YRmeWWFHfGMi?=
 =?us-ascii?Q?suD6iJ9kbIDSLLNluXzMfho0+9nOjaYv3A+RQP0JU/L1Dz2iJnV969rv5m8R?=
 =?us-ascii?Q?iKSofAXQQlNDwOsIQJcOckVB03Kr8d72a+3AJFLkpJ4mjt3FNK1wMegrUE96?=
 =?us-ascii?Q?gqztCWXbLdGodfghTcy60Q3VaLvBBziImgDbX55vcrCPRM5Q5ZB8bw8XCjKl?=
 =?us-ascii?Q?4AET+2UNtTSDt4WChvFsaaxThPeM4aVVSzy+KUXKhbiM5/1zF6VHvHw4a1v/?=
 =?us-ascii?Q?8npebMNjM/JnK53AmR6M1SxxcqiszbT2ARXxbcoNKUydiebk8N6KNHvhOk48?=
 =?us-ascii?Q?sLHLFTb4R7cBuhcrfHVgrMFTvPGDwpa7ZtyDGsgi2LZcnpg40Q84/BYNEgIl?=
 =?us-ascii?Q?qo1z/MFW2qfLhd9d3Njbhm9RaAmt7ZFI8m+k/IMAtsp+R83lYY1CMfKkJtF4?=
 =?us-ascii?Q?hfYlARHt7kZGbnriPludjXK+dwpEaTfBPXAS70b4zkzzONTL3U6ykCGzYEiL?=
 =?us-ascii?Q?fi/wPntZjAoShWRQRRWmnqmpyajOP14KJG8KyBSoGVKh14hhyQUeTN9/Zn/r?=
 =?us-ascii?Q?zmeJP6LR9XE2RQfQFbagLOuJ52wvHUfVPP7A5lw7fQeiLAxxl09SxrKCqTct?=
 =?us-ascii?Q?vw8sDDPfC8fGH3dYy+BU7tBSCeXe2V7bWan8CZqf8f6ET5PRQlONEP6PQG0s?=
 =?us-ascii?Q?M3nR3ZKTaiYTMD9THSa15m19NM420aR4lnrsqV1m73He0uhSs4qJx/MVKsrT?=
 =?us-ascii?Q?CfKjp3xmiI9DqNC8Zlihpa6W8lW52eNUbu04nJfg8iGGkfc3/pCd0OQgZES0?=
 =?us-ascii?Q?5qsZ8c0lo6EpAuHeUmWCrGNiRJdXTMcmifUwTb9bJKBTaayQrnBC8mWOTvz0?=
 =?us-ascii?Q?KaMx2sfjopromeSKfS0bU4xLAot+wGMywInlzPxiteFXwsWVYeTlPFG6nrwv?=
 =?us-ascii?Q?VMpK1BLRDjEWEaOtiHEQHMUvDirAtela5vON7+1B0fYPOEg+ZpNC76ZCI5H+?=
 =?us-ascii?Q?3RgAMdrUo0lc9/hLxaxz3WWhmWMPDESR0etf5XyGzrt0P+N/axdYYv77j3hd?=
 =?us-ascii?Q?3SNjv/9LtAL97qWj+ixhqAhmzoq0eY9gbiJdZgQHjSIpl/6vf419P/zJ0V79?=
 =?us-ascii?Q?1L1vMnagW87N/edPLVB9b3uauNSTwkpyYVNo2Ao+c77efHyy2VjGrezTbI5b?=
 =?us-ascii?Q?f49WgOsvb/EO4ONxtaYYyNVRqWq/OIYiaHKlI/O8USgEZ//DH95ZXlG3btSa?=
 =?us-ascii?Q?XpoYBYPLueI6CbdAO49pSuGA+1sd4yN3tJlA8ytgmgNNgFWTigCPsm/Io2Ul?=
 =?us-ascii?Q?VcvkX+qQlcUKsLq/XOxxZxSbXTypJVksbb2ywPZakO69ztxzoX9p+jBB5TxG?=
 =?us-ascii?Q?euWLfZjZcmuIzDqK1dW/kZLcjQd0Z/H1bg8rt2mMXKFtQ9mZ3nb/sPPO3TIR?=
 =?us-ascii?Q?r8Q02/hZigeI4CME5pp824PzutByEBMEjoH8a+fvKN8UXI4aVE7GWvYZkwjY?=
 =?us-ascii?Q?HYqXNUrqWQ9YdHsijtMia+f+lj6Z/xyI2qczMC/KSED9/nBAkQVFz+wIqNEF?=
 =?us-ascii?Q?voBurQsSlhzCurCZcW6CUig8LtRfG8UYGho/bpyhBfaFQaVEaRs3HmLbQyQN?=
 =?us-ascii?Q?TXSUnyv15hqO+D9ymmrLRORm24GEIEmjNpHZSrkquP4CwRJScK9ky680PgWi?=
 =?us-ascii?Q?7DU+AU9lKG4+13c4ff0c3xngZAX3i2984S5L2pat6R6OvXvQPKrY+p6aL97r?=
 =?us-ascii?Q?SdEAA4oH/JzG303BCOArhvfrZlCyu3I=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ddb08b-9c06-4672-76c6-08da509771bd
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 19:27:40.6590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z218A/B462sH4aXNPIB1F5dGA7zt/hM2yG47VNgUKiqORyfO59m13LFWcgk4kZqf8+ahIn8HkXG3p2zZgQg/YF0qWWTbN19EP+T4DZBgEjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5289
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Cameron wrote:
> On Tue, 14 Jun 2022 17:10:27 -0700
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > CXL devices that support persistent memory maintain a list of locations
> > that are poisoned or result in poison if the addresses are accessed by
> > the host.
> > 
> > Per the spec (CXL 2.0 8.2.8.5.4.1), the device returns this Poison
> > list as a set of  Media Error Records that include the source of the
> > error, the starting device physical address and length. The length is
> > the number of adjacent DPAs in the record and is in units of 64 bytes.
> > 
> > Retrieve the list and log each Media Error Record as a trace event of
> > type cxl_poison_list.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> 
> A few more things inline.
> 
> Otherwise, can confirm it works with some hack QEMU code.
> I'll tidy that up and post soon.
> 
> > +int cxl_mem_get_poison_list(struct device *dev)
> > +{
> > +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> > +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > +	struct cxl_mbox_poison_payload_out *po;
> > +	struct cxl_mbox_poison_payload_in pi;
> > +	int nr_records = 0;
> > +	int rc, i;
> > +
> > +	if (range_len(&cxlds->pmem_range)) {
> > +		pi.offset = cpu_to_le64(cxlds->pmem_range.start);
> > +		pi.length = cpu_to_le64(range_len(&cxlds->pmem_range));
> > +	} else {
> > +		return -ENXIO;
> > +	}
> > +
> > +	po = kvmalloc(cxlds->payload_size, GFP_KERNEL);
> > +	if (!po)
> > +		return -ENOMEM;
> > +
> > +	do {
> > +		rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_POISON, &pi,
> > +				       sizeof(pi), po, cxlds->payload_size);
> > +		if (rc)
> > +			goto out;
> > +
> > +		if (po->flags & CXL_POISON_FLAG_OVERFLOW) {
> > +			time64_t o_time = le64_to_cpu(po->overflow_timestamp);
> > +
> > +			dev_err(dev, "Poison list overflow at %ptTs UTC\n",
> > +				&o_time);
> > +			rc = -ENXIO;
> > +			goto out;
> > +		}
> > +
> > +		if (po->flags & CXL_POISON_FLAG_SCANNING) {
> > +			dev_err(dev, "Scan Media in Progress\n");
> > +			rc = -EBUSY;
> > +			goto out;
> > +		}
> > +
> > +		for (i = 0; i < le16_to_cpu(po->count); i++) {
> > +			u64 addr = le64_to_cpu(po->record[i].address);
> 
> > +			u32 len = le32_to_cpu(po->record[i].length);
> 
> 
> > +			int source = FIELD_GET(CXL_POISON_SOURCE_MASK, addr);
> > +
> > +			if (!CXL_POISON_SOURCE_VALID(source)) {
> > +				dev_dbg(dev, "Invalid poison source %d",
> > +					source);
> > +				source = CXL_POISON_SOURCE_INVALID;
> > +			}
> > +
> > +			trace_cxl_poison_list(dev, source, addr, len);
> 
> Need to mask off the lower 6 bits of addr as they contain the source
> + a few reserved bits.
> 
> I was confused how you were geting better than 64 byte precision in your
> example.
> 
> > +		}
> > +
> > +		/* Protect against an uncleared _FLAG_MORE */
> > +		nr_records = nr_records + le16_to_cpu(po->count);
> > +		if (nr_records >= cxlds->poison_max)
> > +			goto out;
> > +
> > +	} while (po->flags & CXL_POISON_FLAG_MORE);
> So.. A conundrum here.  What happens if:
> 
> 1. We get an error mid way through a set of multiple reads
>    (something intermittent - maybe a software issue)
> 2. We will drop out of here fine and report the error.
> 3. We run this function again.
> 
> It will (I think) currently pick up where we left off, but we have
> no way of knowing that as there isn't a 'total records' count or
> any other form of index in the output payload.
> 
> So, software solutions I think should work (though may warrant a note
> to be added to the spec).
> 
> 1. Read whole thing twice. First time is just to ensure we get
>    to the end and flush out any prior half done reads.
> 2. Issue a read for a different region (perhaps length 0) first
>    and assume everything starts from scratch when we go back to
>    this region.

It would be nice if this was codified as *the* way to reset the
retrieval, but I worry that neither length==0 or length==1 can be used
for this purpose since the "more" bit is attached to the last passed in
*range*, not request. I.e. spec seems to allow for overlapping
retrievals, although I doubt any implementation gets that fancy.

I think it is sufficient to just include the "more" flag in the trace
event and if userspace suspects that it is getting "more" results from a
previous run it can reissue the scan. This is another reason that the
trace event should include the pid of the process that triggered the
results so it can delineate re-requests. Otherwise, the poison list
cache is opportunistic so I am not sure that missing records in this
corner case is fatal.

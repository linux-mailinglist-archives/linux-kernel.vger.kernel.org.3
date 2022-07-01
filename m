Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA55562DA1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236095AbiGAIS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbiGAISw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:18:52 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804B43B036
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 01:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656663531; x=1688199531;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=73qOXj54mzh5bn7snpSdtNZbOJdj9TfQtRUWfAhQ1ss=;
  b=nrW+xr0lrNdiCb7DiP5v/mObvXaqrg1tRZ24D+Aad3JIxwbrfUaekcGe
   AK5yj9X20+fpOET8Htv3CsqPOTC190d0dDbqI340efRqDuJx/CFYl77m1
   wu5imZiGolnazmTf6bAomPvwKaThcK0cbE4kE0vOU19Zl3KHicMpmVsKn
   pqokcbGcYSV8BmxJ5MitoTZuAPkWkvAAguegGA8BH6L/icDedVKmEnbMf
   d9K1PbhUF0/w9/II+oF2mR0qxFYiQwMAnTFA2dgFYZU1/0Bi2Yno1PS+r
   MtctpKNbdpjYiyM9mZDVGWQXmFehZ9UMwfhOFstbqADvKjwBCPSjPeHGE
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="271359089"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="271359089"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 01:18:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="768422848"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 01 Jul 2022 01:18:50 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 1 Jul 2022 01:18:50 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 1 Jul 2022 01:18:50 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 1 Jul 2022 01:18:50 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 1 Jul 2022 01:18:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UD+G2dqQLOOqQIoDrk2KbZkzAUxGy+vor/TP/ItHA3gYIIPCSTTQmbcGbb4tNrxT95toqdQZ6CHw9waOPBRm0sLwRpB7ftKV8xeSTQmJI8IMD6CD+3JrRMc+so/0bhLO6fOzLbF6TiVji8PKPW/vR5C0yP/maPIvIl9KpBUE7Vi9LtH85LaW+VpfhqpRq50qsDmCcTH7Wg24GN6ckYQz7t+GtfazQS/c1lgTPZNjUY/7OsGhkS8wAhQ44h9+2eefARAUXmfEkUiZ+h7uY5T1ql6ZN4AMh+43Ct8I/mnuoTcrbhhBsWIOM5VZUmlLgX/r8WF5Z5ZFiTX5za0oNToqsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73qOXj54mzh5bn7snpSdtNZbOJdj9TfQtRUWfAhQ1ss=;
 b=hWKLRJKUDelkaJ9+CXYMvItVgwNIdrg5heGtCgQp+Xzu8re0golK5LbNeQYNrRS+PpN1oJtAXybXBMp9+NLvWmSbB6x7nJnAYvRfArBbxvl4antlMN/AD+zEC0bcKjr4zpemurIWaaVuemS3ayxr7qZCsX+XuDdth5Okp3pShWIBaYZNPZGmg4US2Xt86e3u0M7C5Jwn8eCKZHwPtP9IPhlhp3kngQDy9H3UFF5cmIa2uAlsTPjJtWL9y5Dp7dqQWmVv7UyKBcZum8jSRz0EkzNtHTStPM79NN2iYgTk+V7xgOJ/mMgh8T90YclMBgcZB+IwmDCJHutCHGiLkjWgqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW3PR11MB4762.namprd11.prod.outlook.com (2603:10b6:303:5d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Fri, 1 Jul
 2022 08:18:48 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5395.015; Fri, 1 Jul 2022
 08:18:48 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 11/11] iommu/vt-d: Convert global spinlock into per
 domain lock
Thread-Topic: [PATCH v3 11/11] iommu/vt-d: Convert global spinlock into per
 domain lock
Thread-Index: AQHYi40tpDd6OUEG+UyFq7K+xVikta1pLxKw
Date:   Fri, 1 Jul 2022 08:18:48 +0000
Message-ID: <BN9PR11MB5276DA58D6BA7B1B366B0AC28CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220629074725.2331441-1-baolu.lu@linux.intel.com>
 <20220629074725.2331441-12-baolu.lu@linux.intel.com>
In-Reply-To: <20220629074725.2331441-12-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a9e852e-0e97-4a9a-d496-08da5b3a52ee
x-ms-traffictypediagnostic: MW3PR11MB4762:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QMvRSG5v3PSj+/NlLR/yQH+DGPN4Z30af37l6kkeGwxBAZ2z/odSSBgBGsDM8MoAVpZeZEBpr9eMRc9dRz4cRyBYVN12xcdqX/HM7k00M2oFD8iSPWLkqRvHifIvExvoNh+cO1UN9DCIQc0hZfkHalLre7C5MNwvyTygcBEjVYZB9MFaOBw7Yx2exHY7elTpm+22IYeP8EPFM+9mYBmhwuBUtVYYM4FfFoYr9lJe0+frrLGlMgHGKQSelLdodlKiK0C99YXJXKX8SrSHFQzUDDxb+tRvwwEqTKUNfMi4esdCC/XoRrShflbm+sRfmKI5tA5ML2attJVsJN2bpGBYc/xYmjqyKPxc7Q3cjbq0feKQBAbGw0Gza8T7Ypps677eLh+pLWpPV9JM6hEGAZqnBNNtS25Ts0XBS4h6k8FaZdvo5Ow09LWsuq4ks9a4juy2AlqDCW7Ymymq5yUEXCuPCburEotBpy0i4oGR52K5TBVBtXEqaxkPnfm2YgQHCjIzjjZgxDtWczxYJkC9gGFokRDPt6gZfz5vjtq1nzyzJkiNvM5k3N/aXFwA2jQvNfgy5jQkd6yeXRWogx/8BoxzcSDu7CRxgc0w7y9wUhV9CyxYEAOszA4N07A2KWYyA5tGwAaR5tyaQ9nhyULCzFVAPMGn/isCtm1znCCdTT+HMVdSAqvgu6LYJrqNYJ5CQ/kJbry8dwKuaWqJDKOpb1rKIgwDDpFSir4zULcYvwX778pD6QQtYBcvoWfIHu5lfyHL7aAo7xLkqysr/+gWKXuT+krIZ52+qpVcclFoDl7y6mtsefgJfgbqKR0gQ0GY9nSq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(346002)(396003)(376002)(39860400002)(38100700002)(110136005)(41300700001)(66476007)(54906003)(186003)(33656002)(316002)(2906002)(478600001)(5660300002)(122000001)(7696005)(83380400001)(6506007)(38070700005)(86362001)(4744005)(26005)(82960400001)(8936002)(66556008)(64756008)(8676002)(4326008)(55016003)(66446008)(66946007)(52536014)(76116006)(9686003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0Mha11no+cBDS2N4wGdhTdUbMUXZwAoCPjQM2g7hSZxtyGTxxAQTbDY4TCwk?=
 =?us-ascii?Q?kTsYfOreFboHxMOLGzokaGjiOw5hiLILCCAVmYmbJBJG5du4ZcCr3gbOzpfk?=
 =?us-ascii?Q?N4nGef4MyBuENavGmkXdqTrn/A1cPHfVBPS5bYN6xbzwPktqBhpuj8jcV/YV?=
 =?us-ascii?Q?ZeYZcPVDF/FDqE/CeOrmWr6U+V9IYQgJojzODbcoW5JoyFjGMbzs5DjGxbhL?=
 =?us-ascii?Q?iHQVoPwkb0O4i1sRakDoyTs7QPcxpLShu68o+U53B9yr3OZu9Mswsvll7a3z?=
 =?us-ascii?Q?ptcexXZFjj84aVsi3Vxgl4ByH26k7kzXATZRrvjs0mypMk2qLnv05ZY+XFq9?=
 =?us-ascii?Q?AapXdWkIO5nXRd/lCpfuX9aksOcuoBhfCoV2XGLspBeuMvAbiCwbf+wNky7o?=
 =?us-ascii?Q?ByMzx5X2RhP46VqvGSPR+T24AS0erJ/uV9ToAepkWejLOFHbIHQOhO3yYIy8?=
 =?us-ascii?Q?P24THaIvg6d8CKBKvb4RTadBX91v+EEANH+En33wgm7RT/XkWbk4BDGgZbg4?=
 =?us-ascii?Q?EDQwLQq4hLWwFwVtsOIrzW3QWggsScGx3n+ZSP1EitnIxllUhwmOil14Dua7?=
 =?us-ascii?Q?m49yd9haa+ZDG3EkTIjMlQBA4lHflbZGYq/l1MjSRxUJwUrxeFrhabSr1PKX?=
 =?us-ascii?Q?E8WSDVL+BoKt8n2fBvk4aBoYC53dGJC3ZTnV6gTh773C6O04yQcAmDoqE8S0?=
 =?us-ascii?Q?QlgTh8zUfi7m14m0v/+hph4o+ltgR93i/CN9InzSiNQJkVioiZCGIwkm3aQV?=
 =?us-ascii?Q?OdDC3UuoS+OSeZ7zi+RRg4vqY2aB1e2vlWWGOqghAWc0omo/kmLR4tdCHUgB?=
 =?us-ascii?Q?/pxUWAnAG3CNMdCyjNOHUGIuVa67t0DJCfgMPM+ifmtVbDYsPMNUJLLZo3P6?=
 =?us-ascii?Q?WayCRvKm2tMUezN23bxsxaOjbqgeIIgiNbPktRGdI5wrfqlhFtDyATJOzNBx?=
 =?us-ascii?Q?r6RM5i6q/PxKTvk/fFLH5qap7g3VCbyxekvtVcmcLySXvRRqcTDqzsx+p+Q8?=
 =?us-ascii?Q?G+iBMtywBGCGr6jHBRD9lOVrPE3Q6EoJSqWWJTrCRQ9GA/gc8NNzjFItaAHS?=
 =?us-ascii?Q?mudNUXCwbXE/EUBa5QORodeWmi8eYO9QAxqaxmV2GDo97xXKozPCLm9K3LZK?=
 =?us-ascii?Q?+5aQRc3j5x0RY92swk4p3QgCsXsuWeojT05p0DfIHlNWXt5G+wCNwiIA4ttW?=
 =?us-ascii?Q?vQvZVg0OEPyvqy8AsAjPxEqTlvQJfbvXoelaIEanbJRX+fW30HXlIT7RScat?=
 =?us-ascii?Q?vRvzhKIwmKs819M43enZaXRV4PsPaeIuVY8d4mTW9vuEUnaoZLPz5qZboodL?=
 =?us-ascii?Q?BEC2DRD9rIr4I91//bUX1IXpu708LTupnD3rjKULjcLigCS4iBxwE+0TunZc?=
 =?us-ascii?Q?xB0/+lxylTJkC5QBt7K+6r4HOV4IUP+VtJ3nR75KMrEdWYemE6Zy3w7cxFXO?=
 =?us-ascii?Q?SONAO2vLG1Rg/emSy3OpG1x7jKcTWP8C03bSpI3vFx7uPR20hqnVMTM0ZUmq?=
 =?us-ascii?Q?yNVqTGi/wqyRTz7AQds7vMoVElyiCl4JPLfK0w1eO0iOwlNie03lXYz7sg9R?=
 =?us-ascii?Q?cihnCDhszXKooW+k4UUm0w2zRbROqTX/ElnZnFYe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a9e852e-0e97-4a9a-d496-08da5b3a52ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2022 08:18:48.3492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AqAvglG1p9Eq6GOZnNyxhQRciV3ZctU7sEvQ6H9ZGgtjMdRz32APGGcLS4ihHfRMzEGfFUtpPLo2OIfItcSQoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4762
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Wednesday, June 29, 2022 3:47 PM
>=20
> Using a global device_domain_lock spinlock to protect per-domain device
> tracking lists is an inefficient way, especially considering this lock
> is also needed in the hot paths. This optimizes the locking mechanism
> by converting the global lock to per domain lock.
>=20
> On the other hand, as the device tracking lists are never accessed in
> any interrupt context, there is no need to disable interrupts while
> spinning. Replace irqsave variant with spinlock calls.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

except the previous comment on where to convert spin_lock_irqsave()
the rest looks good to me.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

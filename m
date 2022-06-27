Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3472F55C384
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbiF0IcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 04:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbiF0IcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 04:32:19 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FCF62C2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 01:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656318739; x=1687854739;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+X+YJjYb2bZe7JIYuETChfxPHOHEUE0W0b8Q6HR/DZA=;
  b=mxn3halka+wsvDNQQH5U/jRNxFfOcbT3e5UmAbjxEx2bcUCPvEEd8lOt
   wZC5QKcP+Z6ru+tuiu76E8bjJWy9y3sJU2FwInSFuMiVFF1wOVbea2oEi
   XE/1Gz0tgP3lKU67xPzSUFYRIQD4416aa8bmuncX5B+3Xuk61udLH1WXq
   N62JZQLL0GDiq/67tyS974wW8HePA9tZVYauAam9lrY0ZY6J+NAxvOtID
   DFI9I+b02ybvoGscghJD5e3lBIVjw6HcjICTtFmmYNEYQgo2xnagXfD6w
   N9PJxpJ+2ie0evU8OzCsFrhuSI82f03ncUupsp+QmTAgBZL9hC/X/w6xf
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="261811620"
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="261811620"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 01:32:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="916626066"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga005.fm.intel.com with ESMTP; 27 Jun 2022 01:32:19 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 27 Jun 2022 01:32:18 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 27 Jun 2022 01:32:18 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 27 Jun 2022 01:32:18 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 27 Jun 2022 01:32:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NdLUDrmf3gu/ZHIUJLa2jSDsNk3k+EtExafDepfhx0aV6k0FtpXUuNg3gokJx6mNBSb/ztMzm02CUYdSeI5Dcsb+BwFBapizjqzdtLc6iirdHJpBzYwmfnyE5wwpGfpEPzK/uc9aH1X/C7BCYlhs29+AHPNYdSEi9DyKKlh5Qkyi9c3ymxC7TSjKDUErUlkQ+PrF/5MByKtSXBGFKRMX5klogt1FFm5simeIFTXgMehCnNiVBlfr24WlQyjV1bDdka/KlZdtCfHcAz0zWFXyqt40kdeOLBQYbLV+KgFDrdnMFsdAby70XmGu2I1efIoKP4EZdf4WMjpFUyv8Og18Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+X+YJjYb2bZe7JIYuETChfxPHOHEUE0W0b8Q6HR/DZA=;
 b=Vco+DHDMu+ELlGTh1jTU2Y0err26gtQmpHQl2FWMQVNdxakKPHNYDqTwoakevmmSvj1kGYMHOU4L/MB6hxmICyBm3qMeF7zxK6nYB+B0L5FJ3EViNdJfZB+hNtTbedp3Z3I4jQKn0PLo5aFbdpaTL2Y1RWv9j5S4EjXLdiD2T/9Hga1i1v9f18mwgh//JHNn0aJE7TkBHrBOP5ESXGZJEPNpIcbR+C+VDsoG0hr7hrU5ympOWNUP1RhuNathRx9yXiuVeJDg/jdVcEWYo+Trr+KFfntMn54KFmUrN8bz6CWYrsfGDi1WzYAeNscZxBO3z88ekxz5rUDGaFLASKE+aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM5PR11MB1834.namprd11.prod.outlook.com (2603:10b6:3:113::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Mon, 27 Jun
 2022 08:32:16 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 08:32:16 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
CC:     Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v9 05/11] iommu/vt-d: Add SVA domain support
Thread-Topic: [PATCH v9 05/11] iommu/vt-d: Add SVA domain support
Thread-Index: AQHYhX3847i14EXDUkqrKBuVCmMyJa1i9byA
Date:   Mon, 27 Jun 2022 08:32:16 +0000
Message-ID: <BN9PR11MB52760BB69F8B42B925C9F5B68CB99@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-6-baolu.lu@linux.intel.com>
In-Reply-To: <20220621144353.17547-6-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36a5fbcd-2ab6-4808-6feb-08da58178ad9
x-ms-traffictypediagnostic: DM5PR11MB1834:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CdTeUCNKN8KEC9AJhzSp2XE0Ubyw15CFY8RGt63UE1p4q9HrfxScl8zYbRnFpJ0ZPxKIYjJ0ztn1CksMQzOXOBkzO1S9Bz2GZBZeyosaLg0E9a76WHATeg9SD2v0QWaVUwceirEqUTusS08dAknRlplu0YmS5KGwfDJglCHSJ52mUGTAKFl22XZ2Bd4tZnC5GtLtK9y/mQ+vgl89F9YB3PrI2WcDkGDZCkPK7Fr10p78MiLcRLo5rwklPsOr9ysUnH8akiRBAbwkwRA2ikvuu+IY6RFwu+31Whbr3+SLldHPmV5iiozFqUgNxby2k9leLZuRFJh9DSAToeA3Crm5mJlTHMkJkyugz9ChANhsaOot7DCfMLf5wgN2fJ2H8//PGqjLMdv3m10H2ZphC9JmZNSFpHy3HpKkZB5FXWIaHr4JTxVZ8oJtFcGMXQeAm9klBRDoWvQlsu5QK+Gfdf9Xu40EyaIcpldnVLA0VYJlf4GG1ci4Y5B1DkXKD2SWvn01YSF8cTOp9BBVxQLnLuRDRch0eC5MkOIdPkeZi79oGFIa6H1njPFpKYX7xZeQvOr1tBazvBfzr7NiPxVlrajl0QAOVvg4zZYxnAtCQOsFzcB99mEPqwA5HkIxEVF0P6W0PsPnPIeV+86GVl7NzDdYUsfuUko3UFJyUJ9g15D+/pdg609m3ArcSw4ESw1MZKzDOS8VR9mm3Fc8F9W9vVrOFfT/bW9d7pHNv9z/qnVZdBOIZZXt2EyF4LHbXxCGqLkbup+cXUNbmYZX5PPB72cLkzmGaq6Umo5XcEPV+aPUXY8GGtlz7ANMJR0VZe6sP5C+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(346002)(366004)(396003)(136003)(76116006)(66476007)(66946007)(9686003)(66556008)(71200400001)(41300700001)(2906002)(66446008)(64756008)(8676002)(6506007)(186003)(4326008)(7696005)(33656002)(8936002)(478600001)(5660300002)(86362001)(26005)(52536014)(7416002)(110136005)(54906003)(122000001)(55016003)(921005)(316002)(558084003)(38070700005)(82960400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9SIVnWisJYGWrAv0gB6hcARxIRWlGGpSamhPyW6FjJd58AKrtYS5seQrporv?=
 =?us-ascii?Q?v0dTR2VBumtBUaSB4WrKFiWQgCwz9EVawn1ewBZcgCNRctVquBI0TN6J7U7+?=
 =?us-ascii?Q?684VY9QPVdRqLFNfFaORe1uLJliqOoKLzDiQ+9A99HH4zBUEESaiiCOereor?=
 =?us-ascii?Q?KBBlClug/hMO8Q2iULsoIccO6H2iT9sEyEbAtDwglXgq1RxoF5iykdm75wO8?=
 =?us-ascii?Q?SB7Rg3k+/pRNt1l0RzHsjwslVFvwZYexCnQlGFd4MP3mYmDWNCMfoFjQ0PU0?=
 =?us-ascii?Q?PY3+bQSj/uUiV4xlOtHsAWRZG2rmKLgEgnPVf8Det1fdedE2nNf3lfOEvIXh?=
 =?us-ascii?Q?J1gWsu6f+sc0jW+m25Y/yrFnTS4E6lTKDTqtfOc02FTGUDcSDxnZ517BclL3?=
 =?us-ascii?Q?P0blHbaM27SxjT21UOLFSkTAYv0KAsVNUDjdEhlwXxs0o/pywsCdesls/29g?=
 =?us-ascii?Q?UcJhkhjesJjWsWqLNPdPjBA8ranv1aF7yN6fAFSHD6el0+T0v5qLfAaA+KSe?=
 =?us-ascii?Q?ZMPcb+pp1KSaIgOIiZ7PaJ1o8RTD2nC+v0Dta1QRpwTWTiD5BsibZq/2ml8t?=
 =?us-ascii?Q?tAWhpIOG4VEslGV1cKdgKvlgv/RUtpWiUexT52abnGhsPuehAsTB5B40CbS6?=
 =?us-ascii?Q?5s84KFsvux35ajBilGSr3Ttd/yrg6I8gXILVPM3Jb2ovPfuzzH4NNV5XYaNZ?=
 =?us-ascii?Q?9s5qzzonlrE8OgVajsMJp+VGtMFpZ027zCIpgi8hPwEg8OsQPuarCDZYaV8R?=
 =?us-ascii?Q?aJUe2vBTBa0A5VYW1IlpnB8JMke5TJZoMbFflKZpe+qSyV6vDXcKLLwVVtyA?=
 =?us-ascii?Q?6fKjfOc2kD+dPxqAIdrYXd3FtEAQ8fSNQuzMewUOnjAJkxh5mbytajIHFfOd?=
 =?us-ascii?Q?lkaE2buQfmqB3TEB/sOWuVzh3T4imZjuHcfABDflT+J3XwF622wimU10aWVp?=
 =?us-ascii?Q?UhioLt1/JjeoCDj3Yj74vP8XDfL7E1GA0HDeK5c1HAI+GjTjpH//S6bV0L1j?=
 =?us-ascii?Q?JEwtAPV0pIwCSbFK+laeyzaDFloFguKNjS0UHhzfhkgrnmYzkliMrlldjTmF?=
 =?us-ascii?Q?tkTUlnpEz5i7zEJfmyS25qSjsDhFHQVO+VbDfowyA6vH7SRbods6WFxsYrI0?=
 =?us-ascii?Q?sIL9IcnxV9pboTxAWx8YipUO3+8onbE258h+572XnhaO32hxqpf1ytaMEtPS?=
 =?us-ascii?Q?d7Rl20w1cyXL64L3k84//GePMSTSvHfIzBGJuliAnE6c5ZDy5ILvWc30Kntj?=
 =?us-ascii?Q?FzOtGCN9C8M0PmdYbJ6cGqQceK02C4whV8eknns7ZDhIIdTTIDexKZDqaQ5d?=
 =?us-ascii?Q?NfmgM4cQWbdCIcoacPyCM5f/Q/3ljSQ1HBRUU0M1SlYzO4oIDWb8Y55vN2ca?=
 =?us-ascii?Q?4YPUfqB3S3Offfr8EaDuiHNsjOo2bFa64Kte0U3WefKE2UiHevzjfkjv8QVZ?=
 =?us-ascii?Q?VwEQELo2mT6waAvHLR+aWgzMhmQOqSeBd/fVySUSxEtIgpZsx271nRf0H/qV?=
 =?us-ascii?Q?Hb/Ntgn+jqiG80rqaJE1JspBMpIahvcYvOw78hXK7EMhYJAP70/7XAoiDTs3?=
 =?us-ascii?Q?pe6+WRhtKRCabOS7MdkOyW5gTWoihMbLJFfQEmmY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a5fbcd-2ab6-4808-6feb-08da58178ad9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 08:32:16.2875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MQ1XLLx2c2Byn1etExJiN5wEPKFBN61Ylzaal9e0sACU8EwW9RpJif7YxkbXCezBaxnG7FNrgGsmv5BlOC/ftw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1834
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, June 21, 2022 10:44 PM
>=20
> Add support for SVA domain allocation and provide an SVA-specific
> iommu_domain_ops.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

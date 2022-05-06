Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DFE51D111
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 08:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389363AbiEFGOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 02:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351246AbiEFGOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 02:14:40 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A961553B73
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 23:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651817458; x=1683353458;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Pho5bRvKekUDYphRiGr4J0uLEshUwgf8u4ndzYyza9A=;
  b=lhP7nCnWlnJH4k9iXrEnLD6SqHPcBWjRDdFKhZhTu15i2uAJgrdKOQUU
   GNZKwncfFryI3KhU8cn1sFptFJuOzjEQrayvFFYr5qMizlJD+3298/Bcb
   iAysP2zm1ixNNbKUoRSYPL+NKZ4YRBPcs2DIcS2KIaZIzM81pZE6KyB8x
   PQXi39M9YIyUMYhcN0h/hvXiPl9sxMU1RXxO3rt5q5P1tKbdGM6181Bgl
   L5cA/MrBnjrRA8thf9C57Q20bQaWz3IdDtcgEJNXYkfLCO4PJ6uLIU5jN
   kKFTZLRS181OkCsr+9WpOhRE8l6PUSWCWj4mYTrtnWcRhliyfVTOdF/Ap
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="293570282"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="293570282"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 23:10:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="891681196"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga005.fm.intel.com with ESMTP; 05 May 2022 23:10:58 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 5 May 2022 23:10:58 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 5 May 2022 23:10:57 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 5 May 2022 23:10:57 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 5 May 2022 23:10:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tmoojc11R2u3nzyOuRPflWUaXlwwwCrdNO+BMnUbETkz8KrDEyZ4Gma7kcdgl5XtCa847JaoFtBaiwP9YGoHRTuwvFASO3DaYu02itL+70f6E1Y2j7TgeS6bsCuZ+0q5sogZf7RzRXZk7e0TcEtr4eL6XVnXydKpTESVmvU8NOnuou1PVRJdAuen2iV51wJV80LzqfBLXkLg1QroVI+hpAnOJrF4pDM3mt+AXYmhZt3H3C55/0yURsxuUuIeBuPimKRTOYoYhlI7co4rJo5FRcUmusr1VPKSbDulkZBXBs2Umha0THeZhQ77k8bpie4TvfkeIcIIB9VpdbCrP3bBMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPJ/+9ZHGY0zcDM5YKL4PwfnfvOe5+Pd9M7WTUpNDz0=;
 b=eSgRQw273NRMACRJZ0ARG1edTk4dcUfWc5X0gWeU3mB9bdEm3Uunk1q+1JncX6plhQKlVwAHFetEhpMDgVq2G5AGpnFgaV7/qCAYRuXtA6Djxj45bkQlu81ss49zrqEWo7CkKGeHBlbTtp7El5A2bBGUtE6Ie0IvYIZasGweJVAzdLIlPrI6RLLKWKz8bIHKXeIMUGwKxwoNkGZ6Aq3AQSdxC7jExE96BzYaqyU5WOx+Lspw+jyk2e7oC2Ixxv4GESbqp5fELS8ijiMcwgUpyKSMYEkotsVuEo2ZZdFqtd9NGUTFsdj8cE9Yn7vDkpZBHhdDnH8nHNgalme0cipbmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB5343.namprd11.prod.outlook.com (2603:10b6:5:392::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Fri, 6 May
 2022 06:10:56 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5206.027; Fri, 6 May 2022
 06:10:56 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>
CC:     "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/4] iommu/vt-d: Check domain force_snooping against
 attached devices
Thread-Topic: [PATCH v3 2/4] iommu/vt-d: Check domain force_snooping against
 attached devices
Thread-Index: AQHYYQptF0jz0aFGH06w1iY72Pdfsq0RXDog
Date:   Fri, 6 May 2022 06:10:55 +0000
Message-ID: <BN9PR11MB52762145C90CDAF980E5E3EB8CC59@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220506052727.1689687-1-baolu.lu@linux.intel.com>
 <20220506052727.1689687-3-baolu.lu@linux.intel.com>
In-Reply-To: <20220506052727.1689687-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 344fae1c-18f2-424a-08c7-08da2f272eb1
x-ms-traffictypediagnostic: DM4PR11MB5343:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM4PR11MB5343630EEF71556F905FD8D68CC59@DM4PR11MB5343.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E62NNn3UemtnAZgmXVNmagRmWG7HD1lFL6PKwEgpnyf5jT40vC06yycxrxJLnSSpT5DFOLr4VDZE7JHW01ZCKVmhNK1QThtA4/dawajYo6GTzib20hz512OpUqf2jn5umrEAB1IKdPUZITCAYvpnMQdIcZaCZ/N6FNKX2epU+OLnhMZLCrE0u/v3ZUJsG9Rat+a4MgDi+/E3ueiZhlGnRf3qFxvIgs7tsxUFSV3zlbqCj+RgTWgdV8WoQMCi/LgGdvJf4/NsZAoMVjyionVgYuN81SP9cRza+s3Wy0bVEIK6T3oBcKktHvTwAsz/Rp9b4vOoUcOsWyZQ5/t+z5CGD6uGNjKauMJSEUHNrByn+RhSN9P5Mi2OmoesLNhmA9Zz0eawGoy6MeC0tfyq03S6RN/2cluuGSTfqw1qzGm6NzIXnVFifHHivg+fRreffcPoJ5/XFhmot3G9AWj4p7CQyAmty33Rfbz4BVgF2YZ+6+A+o6t8ipIPn2KP6YD/TBk27heG2roVn7a+fUDFR95BW7gQXRbOt1gIPTmmJc5AWAXF/UQXPEjetx+1mfQ7wj75p9/m4Z3wRMhfNC5/8iLmOALft714bEN1N+mT2rPOYDFZ4B7XLZXjLVW+Hjgazp4Pia2TTKLzXc91u/kUWzDnlMgSPcoDVrkaWvu3N9ukzK34yrIbgZZ+KIAchM9Hr5+vUajb/VmIwkCV5pGH+T/yPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(33656002)(83380400001)(66946007)(8936002)(52536014)(64756008)(5660300002)(186003)(4326008)(66556008)(66446008)(76116006)(66476007)(8676002)(71200400001)(4744005)(110136005)(26005)(9686003)(55016003)(6506007)(316002)(38070700005)(86362001)(38100700002)(122000001)(508600001)(54906003)(2906002)(7696005)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Yh8OPu397FOjpCVUCcU72BMfJwlKbLO66W8gNNE7Y9Sdeyq/PJ0joOs8wBrG?=
 =?us-ascii?Q?+SbgKRZ7UcxZbNMPR5VM5+53+BUOLg48NTIBHXTtC6/OWNkmqIyCt0nyT77W?=
 =?us-ascii?Q?bYv6qKrDXHWE0LSW4SihVGiZfz53D1r6BesHiCzij33Omod2EM/fkrcLCo41?=
 =?us-ascii?Q?/kJ/jgLYxroIpg0gLSRTWkBgYpk8qy+SUu4TV/hd7hm3slOtZ9F24fUPw8w4?=
 =?us-ascii?Q?vf8EIMWjzrbKbVmma1w8TKrrlVr7SVTZ1fr+t0h8f3nFivTdiTZKTqb90v25?=
 =?us-ascii?Q?BPayu9aMcOteTtfgy10aWh0Axk4CfBnN+SwS+1k1BSU9Ti74sGU0HmJEa4fC?=
 =?us-ascii?Q?Hy2G+xJpG9LmLn1QH7Vvjf8WccUpTCya1HeEosBY9ewxi2fbswJ798Fu7cHe?=
 =?us-ascii?Q?WPg7L9y8cELt4VBMFS3DchOC3TcuvLT9VyuJmuwLBIhNaQVENsMmtHtapJ4q?=
 =?us-ascii?Q?KzXy9OSpyABCuShg8b7rwO/eJLTKqgYKVykmsuqweIUKUgxXQ08ftgfOqnZl?=
 =?us-ascii?Q?qZeWd0nAzPMGAhfCK/lJB26en0wK4sBbzuYb3oDWIT3JxF1EH9Upys+Gi9bU?=
 =?us-ascii?Q?7JWW8q+mK9ZXplQec+KIgJT+2uUwD0OkFqUB+cCj0yfS39arwR5BE5t3akRt?=
 =?us-ascii?Q?GpusTV2OEFO9h8J89Zy03SSGnisSsO910xB8lE6AV+d8JiQa2Xk8bpO0/b7K?=
 =?us-ascii?Q?2HaN2X5a6fh2Cn5VBiassyqX1m7Dh7SG/7e1GLn9Na9cdzNxSK2IcR478qzV?=
 =?us-ascii?Q?M0gIwEIE5Mw2QL9GSUcBrLNbpO76pfDQ8HFMJFyvKazsmZcu38mqaO4razN4?=
 =?us-ascii?Q?GzkPEfEx3WXQtMudfQJRIWgI67nB4UHTzbev3q9N6ttqlE4cxsUozIAt0ljI?=
 =?us-ascii?Q?9rwkRQYBJtqFRdQ3Ui1LWk+FCUhgMxemKErxNgK5a0LZlJ+UJk3lMiWhwRtg?=
 =?us-ascii?Q?BRFnGBji+RYLXaAIwUwoeznbp/gtqGcbKOXUxIvGoK7t4MUd8QQvQRpkCxm7?=
 =?us-ascii?Q?8rJdp2iEGNLhBvgYQFaMR97yQipJAD9GiSeKUeDCVwaqKEOe0fbkPOeRKDBO?=
 =?us-ascii?Q?MnG1oaeeu5BU/mJYcIeTGjtHO7me20QKg8uk6UD30p4ZA1u3DHXL8BhhYl2v?=
 =?us-ascii?Q?z8mplKZyUE8RaPFN4VlunhhyiKvVgCVdrOTer1Mrk3ZmV4tJRlhoPoBIjvge?=
 =?us-ascii?Q?NLeRnrN+ju/yPOu3e31FwNq4u6njKvbLQQH4U5pyjEWxLFKifA+Melq/g4PU?=
 =?us-ascii?Q?G40Vxh6uwWMzJrLDaDDh9wziy+IOAgbEH6OGAUF1owDUdJKjejQ2mkWZK+8v?=
 =?us-ascii?Q?/Mw8zlnFW9rvyVgY83LwHVDnEe/SuAJsguo2HoDg7rX4f5eCYf3St5aLHSTE?=
 =?us-ascii?Q?ffGSuYV6r/u1b0WuBHne8WojwyQTVI6iQLdp0gPkydnrUNomkpUsZk8CB1uO?=
 =?us-ascii?Q?no5oMFEU7gnG1rIxPED/UlODgZk2HrjJ3YPEJMhGSvOHaWLqPZrL7Pi8u8j3?=
 =?us-ascii?Q?chAUYVIJMOws8Ri/XrqXvMSrq/9J05FiAAh6R8MraHKAZEMun94hwubBzoZv?=
 =?us-ascii?Q?mcR23LtUs48GdWhyTILWYXwXrphmtVvur276raUvjUjRFJWfFLQ6HwJfgasu?=
 =?us-ascii?Q?tkzG7hZloEfKkZk+8rzwvVhDMR0CT93bD1MMEPGVSmeyL1BntH82JawrrGgU?=
 =?us-ascii?Q?mSjT5lpPJ/N7lxrVCjRHbROita0/4z+2tZC79ENXmLBeJj66GT3gLu6eL4U1?=
 =?us-ascii?Q?tPEU6O0aJA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 344fae1c-18f2-424a-08c7-08da2f272eb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2022 06:10:55.9461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7+XfdhrEOdmLxy3mJ5ZdOeKA27psAy6RJEuY5b4Q2M5NmjrBu6Z7Bdx4U92rpmB/+SdChQmf0PNg6/UAces97Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5343
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Friday, May 6, 2022 1:27 PM
> +
> +/*
> + * Set the page snoop control for a pasid entry which has been set up.
> + */
> +void intel_pasid_setup_page_snoop_control(struct intel_iommu *iommu,
> +					  struct device *dev, u32 pasid)
> +{
> +	struct pasid_entry *pte;
> +	u16 did;
> +
> +	spin_lock(&iommu->lock);
> +	pte =3D intel_pasid_get_entry(dev, pasid);
> +	if (WARN_ON(!pte || !pasid_pte_is_present(pte))) {
> +		spin_unlock(&iommu->lock);
> +		return;
> +	}
> +
> +	pasid_set_pgsnp(pte);
> +	did =3D pasid_get_domain_id(pte);
> +	spin_unlock(&iommu->lock);
> +
> +	pasid_flush_caches(iommu, pte, pasid, did);
> +}

The comment of pasid_flush_caches() says:

/*
 * This function flushes cache for a newly setup pasid table entry.
 * Caller of it should not modify the in-use pasid table entries.
 */

Can you check whether that comment still hold?

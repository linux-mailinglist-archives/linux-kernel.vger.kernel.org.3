Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263A45825ED
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 13:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbiG0Lxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 07:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbiG0Lxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 07:53:44 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29A23247F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 04:53:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqXwHLhKNwWsP/9aBz97/msmxooBX0+SqLxxhftCHERzWEmN+nXcl05m136NZYjw7vuAVFoeKsqfdV/3ocM84fVsBvM3lHPyOAoBnCDUmfZnweU1yPjOm6aWmdNOtT9EVs0YJ/d5oytO+kkXjq81vwAMGI89wLRAJdfgKOUAdQZdpx0PPVXE7CWlJGn0aczsrcLxPnoaOBmnBpLAnHFDA+Vtg1Jkxo1aUjE/u2H/AH5UdCeICmgt8cqEgnUSkzHgqFPX2HN7dBg2sFB4dwD5cx2jP5nphLb8E69MQm7Ic3jbj2PIzwGnpciaWjT3OF5QAfb8B7zb+1f7RFILDjXZpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjKtUzvWXxRb1ZkCq7wBWeQEJavAFvF8AzdyPh/b9mE=;
 b=GzFcr/nEb6KvRb3/S2YtjtSuwZ3O5724fxtMTYUgrbqtCgNIRDIcTCUA3cpstfQxEawzOKCx4nYWu3VZPVbHlejwHZDVoLP98i7CXlYy3iLRsj1dOU59SCVJTtkr45JfwZwVHxXOjko7vN/9ip7vzjDuPw6EfnhQGFlEq3OgcTTaSA9t3w+chak47wvNZMLSo1yM5v3fKNcEazZbkbPOAuFFnjOrQ+0Qs9/tyUozFno1O5G9qI89nHOZVmQ/ivEGQridTQG6u+dd1FgrkckkOlDtUAswUoUfUN1xh+2K8/jNjgZgT0x+VVSYtSEJW3mGwiceaOJ6uqk1SUtBj1T+jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjKtUzvWXxRb1ZkCq7wBWeQEJavAFvF8AzdyPh/b9mE=;
 b=LXPj1pBz9GjHV17ojr3RfRt2epeljnuffxnUKaKUjVEgyhh8wyFdZeJlmsGUXlAgYzme/BzfQg/vCr84lFDCnMfeBIeNlVvT1e6VGXLCFFXCBa7vZn303PpqCyWY10aABWT6oTe11XqCL12Vpe8UsFpCR4wnyzfXVPaxMLsbHGX/k4us/kkW0Ijej0WTVlX1jNvvX7Dr8QKGH/+Gnan5P9vQOOF5fY8YXbJGokv+b+r3EE/AeN1YkmX/4tWi/fOJublJS0ILa1CBf3YOvqGbYO9InYwjQvzXrf36TSogk6iqzu0dgF5BRrEGJ2yywHddsmhVRRLF90P2Zu/5qKycag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BL0PR12MB2563.namprd12.prod.outlook.com (2603:10b6:207:4b::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Wed, 27 Jul
 2022 11:53:41 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58%8]) with mapi id 15.20.5482.006; Wed, 27 Jul 2022
 11:53:40 +0000
Date:   Wed, 27 Jul 2022 08:53:39 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        "Zhu, Tony" <tony.zhu@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v10 04/12] iommu: Add attach/detach_dev_pasid iommu
 interface
Message-ID: <20220727115339.GM4438@nvidia.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-5-baolu.lu@linux.intel.com>
 <20220723141118.GD79279@nvidia.com>
 <686b137f-232a-2a78-beb0-e4373bd20959@linux.intel.com>
 <20220725144005.GE3747@nvidia.com>
 <6da27a6b-b580-4ba4-24c8-ebdfb2d9345d@linux.intel.com>
 <20220726135722.GC4438@nvidia.com>
 <BN9PR11MB5276974ABA5981A7361953708C979@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276974ABA5981A7361953708C979@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL0PR0102CA0012.prod.exchangelabs.com
 (2603:10b6:207:18::25) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37f7cb06-e1ed-480e-8e9c-08da6fc6a600
X-MS-TrafficTypeDiagnostic: BL0PR12MB2563:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jKZBjct8TceItirSJN+hW+sx1x8v2NpOwJc06CM+NcFbfa8Psy+41XBNHAiVVVn8t0W1APUY+ubcqtihV38TDNDj/kC/7/KeAiW2KFxTRKp7IJlYYrWvr0mdxfjFeFZLPnX9CW5zm4E7B7ksSCzyogL5+bu4kQRUPf54IdGejlLu3LQUsbB0wS/DEGjB0MJAvOxg2+3NAicRKfCNhRVy1X0jrNhmorgejPi/8prfDILdLQ+Q09HOEBwwB5XJ9boB6jQXByuH+ShcgzJydB8tvurhD9A/aQtjdZQ4OjLHe3Tr8p9piHMq5zLUGhJe3HZ2ofopo7+IhjWnbAXWsj/r8OWcWTFrMBcb/rdtfWLEGoCnaJbSiebxOH49AArAdEtgNEwk4dN3U4CCoXKay7rMMBVn8rbH7yy+YviF5Cudp/Ki+xv4EyWevTNIdkBCPONPvBpjQvI3kyB7DmF9HnUs2Dj1oaZgiY8J7nrqpu4FpHnFk29s2IjmPinqxFA7fJTPYA6iAx1ecH1wF0/DvqPraHfxJfm0IXDBeSdPB+Ws4J6twkSRC4t7vdJmmUjjtFXvTGPThWO63WMet8t8xOAJOZWfMJLOOpb1iXMx7CE2jR7EU+7NvTlmCnYozJmP1DKKCjZblyteNfYl20akoa3pRL/JEc4a1wd/x5uIlI+oG/DsOfL1g39PqPXjJtVq37iYCkzWuD0FG66VHvyqmauLzP2zA/HJ9JYAQDT/FFghSGfc8G0gCB2PTObOYeyj9kw5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(83380400001)(186003)(66476007)(41300700001)(66556008)(6506007)(8676002)(66946007)(36756003)(1076003)(6486002)(2616005)(6512007)(54906003)(26005)(86362001)(5660300002)(316002)(7416002)(8936002)(6862004)(478600001)(4326008)(33656002)(53546011)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?txV8Du4B7SXhk1N0CckJRS0Xab7gMu+UOKi0dJcidk5jeNcJOIG2SMGC3mob?=
 =?us-ascii?Q?9XqPFuMtrGEkyAHkKhPNil8bkrDaVvHIlLGYyN4YGTVHUqVuokDlZL9gR3KN?=
 =?us-ascii?Q?TA9nyAzO5uqcjtykia/nET31sydkpX1yS2EkcPtL3n9DMc/IL0nIrT7eoXhM?=
 =?us-ascii?Q?oP8XkNIUp8eoW9T97lOA8LNI3xkmEDHa1ELFdkDFJghgbhiBInAFC36XqmME?=
 =?us-ascii?Q?qi9azqORia1RHdS/rNNCJ+FgW6Sc7sb92N+KrPb1yeealEZ07erYo5xoxqJj?=
 =?us-ascii?Q?XTENolsRiU6w3qRjXabKhncaPZgs8nAthQMvPMnxiOoJipDgxLxGzY6YRmep?=
 =?us-ascii?Q?ID4W78TL8j09TZ141Mhnf+bNy3Un8vA9toK8wbPlh7a1dAbTbn5ieJ/jpcxb?=
 =?us-ascii?Q?Mkhtpx0nrD8rvIGsLREn9PA67ZRQ0gwws2+siq+OOy1Ls3/VbRh2fnWuEG+v?=
 =?us-ascii?Q?s75CJtIk+6+P06vpDul1+BfmdZse6xHEncaLscvdINvY/JkX6OxbT46BnN/N?=
 =?us-ascii?Q?XLyL5FpgpOWFJlwDHebAUZEdKbRc/po2Wp8geHNX89vS6g5GYUqkBJQ0y2yk?=
 =?us-ascii?Q?yffG8EZyi9PGMjMZYBPiPHdhvtGZk/jic1XQ3N8F37TXXbD7hprrvKpmylId?=
 =?us-ascii?Q?sClvBZFCC+FaO6BDnOJlSDLnT/NGV4DARpoqa0KOAS5Y6LED1NkcwRjtA+i0?=
 =?us-ascii?Q?GyOECX7PJKALVmDJEPyOf304HLbORv+SgOS7ALWlcDyNxiszILdvlWOowdAQ?=
 =?us-ascii?Q?oICK1tg3V6aqMf9uvlLlBC9eE/AM65ab643UJDB0IwFizlu54DbHQK/eaQkz?=
 =?us-ascii?Q?SAZIO9Mj9Plsg6gNHhdnOmcyBJ5UB2s1nfaaFnyXU+01uar+g/oyIIPvtARp?=
 =?us-ascii?Q?RdeP7LAS3mtEYkENoB19rMrwpYdJqx5a0zIeyIrOvpZ2xLEMVn0PsccKeVMA?=
 =?us-ascii?Q?HP9S4bpdZ7KTr9Vm9u946HlPGxZi2yL0GZ84CDWSgMQvBDkMH0gWYmXJoz+M?=
 =?us-ascii?Q?4cYfgKbzDcHiKBBMWpCoSw2f9mG6lWp3b2fxOQxWx8knXo/rzPX18xilQhji?=
 =?us-ascii?Q?eux9Tz+bxjCqRTWtkQd2j0YLILbzDsJcMeHXmaA/8ZhS8kerwakHTHB/BsSw?=
 =?us-ascii?Q?yDLXBfHglZd0t/rgLnvXnH6qy2lFwfJs53Pg1gQRDY7CaDbV29XPEkefj1hi?=
 =?us-ascii?Q?yAhIziU7uajqKRkDzfemyNpoboVt2MdZdlcZAq9tm+f5V7lVyWjLXuwqVuNr?=
 =?us-ascii?Q?C4hyxg8UsbYuDe5KUEVt4L5IiEM21XXfSsvSFArUaNETQoyys94DS1oZhT0b?=
 =?us-ascii?Q?AhdCzHGymqSV80wBl6bZP/T4kbLFgl/6XYquVPgkfuQT9TOb+U7NDa4hUJ8e?=
 =?us-ascii?Q?PyG4uEtq2RlCONthp/H4vuYaw2mm9rM562I5I1UlSvQpTMjl0A4QKCdiE9Us?=
 =?us-ascii?Q?/iOszucQjHvoMJYnwADg+tOzZLcbWLbH4v9H/e1kBtIcuaUPpYCZtL8lyraK?=
 =?us-ascii?Q?MyiKo/F+JKlKmi5l580HDTf8uQ3TteWxWnwNMNF2/G3t7VNrKtot4Q79IzeN?=
 =?us-ascii?Q?5TdfO0R4JGha5H0s9p/nReSEsksY8x2E/rxPiiN1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f7cb06-e1ed-480e-8e9c-08da6fc6a600
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 11:53:40.8889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZJ/0m/IIgR3XIr1EZeuASJ8Nmm1895aai7m/w3WQWORJSDXC2jPAp2srTTDMgdne
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2563
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 03:20:25AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, July 26, 2022 9:57 PM
> > 
> > On Tue, Jul 26, 2022 at 02:23:26PM +0800, Baolu Lu wrote:
> > > On 2022/7/25 22:40, Jason Gunthorpe wrote:
> > > > On Sun, Jul 24, 2022 at 03:03:16PM +0800, Baolu Lu wrote:
> > > >
> > > > > How about rephrasing this part of commit message like below:
> > > > >
> > > > > Some buses, like PCI, route packets without considering the PASID value.
> > > > > Thus a DMA target address with PASID might be treated as P2P if the
> > > > > address falls into the MMIO BAR of other devices in the group. To make
> > > > > things simple, these interfaces only apply to devices belonging to the
> > > > > singleton groups.
> > > >
> > > > > Considering that the PCI bus supports hot-plug, even a device boots
> > with
> > > > > a singleton group, a later hot-added device is still possible to share
> > > > > the group, which breaks the singleton group assumption. In order to
> > > > > avoid this situation, this interface requires that the ACS is enabled on
> > > > > all devices on the path from the device to the host-PCI bridge.
> > > >
> > > > But ACS directly fixes the routing issue above
> > > >
> > > > This entire explanation can be recast as saying we block PASID
> > > > attachment in all cases where the PCI fabric is routing based on
> > > > address. ACS disables that.
> > > >
> > > > Not sure it even has anything to do with hotplug or singleton??
> > >
> > > Yes, agreed. I polished this patch like below. Does it look good to you?
> > >
> > > iommu: Add attach/detach_dev_pasid iommu interface
> > >
> > > Attaching an IOMMU domain to a PASID of a device is a generic operation
> > > for modern IOMMU drivers which support PASID-granular DMA address
> > > translation. Currently visible usage scenarios include (but not limited):
> > >
> > >  - SVA (Shared Virtual Address)
> > >  - kernel DMA with PASID
> > >  - hardware-assist mediated device
> > >
> > > This adds a pair of domain ops for this purpose and adds the interfaces
> > > for device drivers to attach/detach a domain to/from a {device,
> > > PASID}.
> > 
> > > The PCI bus routes packets without considering the PASID value.
> > 
> > More like:
> > 
> > Some configurations of the PCI fabric will route device originated TLP
> > packets based on memory address, and these configurations are
> > incompatible with PASID as the PASID packets form a distinct address
> > space. For instance any configuration where switches are present
> > without ACS is incompatible with PASID.
> 
> This description reads like ACS enables PASID-based routing...

Well, that is kind of what it is.

> In reality PCI fabric always route TLP based on memory address.
> ACS just provides a way to redirect the packet to RC, with or
> without PASID.

Always except in all the cases it doesn't, like ACS :)

> > > +	 * Block PASID attachment in all cases where the PCI fabric is
> > > +	 * routing based on address. ACS disables it.
> > > +	 */
> > > +	if (dev_is_pci(dev) &&
> > > +	    !pci_acs_path_enabled(to_pci_dev(dev), NULL, REQ_ACS_FLAGS))
> > > +		return -ENODEV;
> > 
> > I would probably still put this in a function just to be clear, and
> > probably even a PCI layer funcion 'pci_is_pasid_supported' that
> > clearly indicates that the fabric path can route a PASID packet
> > without mis-routing it.
> 
> But there is no single line in above check related to PASID...

The question to answer here is if the device/fabric supports PASID,
and on PCI that requires ACS on any switches. IMHO that is a PCI layer
question and perhaps we shouldn't even succeed pci_enable_pasid() if
ACS isn't on.

Then we don't need this weirdo check in the core iommu code at all.

Jason

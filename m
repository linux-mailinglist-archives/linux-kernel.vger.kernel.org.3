Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC191597375
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 18:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239153AbiHQQAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 12:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240409AbiHQQAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 12:00:33 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151D69BB53
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 09:00:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOAf2hUZUlRSY4Oc3Iuxm9Z11aLyYppK/Gi1qkTQ982By5GxwxXvoDiKSx8j+BjNK+WN/8e7909Iw10qkKctFRbmuFGLfqvklzEPZw9Jruj+MSyF6arNUK7kQKjMZdqI2+iQDmGNJVCZtUHV06U3Xlh64wXSlYnri1DteTSfz/aptQcLgpw4BKfuIkbOeFW2XStZKd/pZkko+YZuMXhFTmnjZsjVTd5ryKckNdmrqd37HBLdr0ARPOOJnrA0qrWm5kYcPFBPdGb+t2OG0k0KnQVULO6XCtCYyVzpnccoMfwm8sLT/Bd+UXyfk3JrzTYFjT5KKAYypB6e8ca9GX0Nww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OaiL6Trc95nbRKl//QHAqS6TiqqRQVV+RISwCmG90R4=;
 b=AQKUmKCUAeoGaf5Foh/dvesrP6XVAevBxX2IbwuYTOXInolaouTGso/JO9q3gKm9CVK6wxamtuMDXOF9RnXGz5Z5iwqLoToy44N3aGFa86jt79RafXehLWUcuD7SJ8bksxLrTnSE5bpePi6+tYpwhU7GtHgQtZuBHEknDfO1zFSLGcR9b/Kxv6jnmAKxrIY8W6kAe5FV//AAQta7bzYgTBCMADlmP+x3bsGUpaLuzBatqGOCNEYRzRv77H4kSGrRKn6lIFyQEPgB760Wc+UXh9k/pp2bRdXqyX5I2xsCDlCFVVUeGqr5gKsG2EpOlOnzxTEzXsi2VZ3SHEG/VzEWaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaiL6Trc95nbRKl//QHAqS6TiqqRQVV+RISwCmG90R4=;
 b=sHaAtKYlkk9v0AzEk8IbNrJuEdf1ockjlOXs5UZONNH7j5kODGhYOddRTIPWsacsr9m8YboxYGos/38YVjcHJE8AXfHFLbCnmOjAn4wgJGS3cK2Z6Vdti4UPojADa8knKLt5E4o/EoazPsdqG3UKaogdbqhiErOM4uVzIPi+mZu7ERCrrg6oyngeJXCWEHqYL9hkuSqwwliTiP/RUGEotucZ8qEO61NL6qAmETpPwC4igXlaIP5c1pHp9u6ANG+kyWN/aIP9lTb6z+2yV30iRBh9xsTuH9N/qLYan41jUN/KDRiH6LWvWU2v/r4vz/cl7FelECjpZ/cqTTY9BuEKAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN0PR12MB5932.namprd12.prod.outlook.com (2603:10b6:208:37f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Wed, 17 Aug
 2022 16:00:29 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%6]) with mapi id 15.20.5525.019; Wed, 17 Aug 2022
 16:00:29 +0000
Date:   Wed, 17 Aug 2022 13:00:28 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Nipun Gupta <nipun.gupta@amd.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, maz@kernel.org, tglx@linutronix.de,
        okaya@kernel.org, harpreet.anand@amd.com, michal.simek@amd.com,
        nikhil.agarwal@amd.com
Subject: Re: [RFC PATCH 0/2] add support for CDX bus MSI domain
Message-ID: <Yv0QnAMWxL7p5W2g@nvidia.com>
References: <20220803122655.100254-1-nipun.gupta@amd.com>
 <846c663a-5999-977b-8a69-89c8ca522cea@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <846c663a-5999-977b-8a69-89c8ca522cea@arm.com>
X-ClientProxiedBy: BL0PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:208:2d::31) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ef78ef8-38d6-4fc6-2561-08da80699b42
X-MS-TrafficTypeDiagnostic: MN0PR12MB5932:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CxtgIgZHJ3ZagWFz8THwMAadeP2N/FvNxA8KQTZdYLcQYUAOjhtjRShzEq+4YGNCkkq1wPW8p/EoApcWX2XmB4uuEWHX4f2tyRewvy1KC3uRVYUxJPro7mrOL4OPORbbIJnI5UQcnVGhuISVS0+12RbchxRQikDoV0x6ElTXF25+O4qq9ES1RD9xTH2ufHvuw7oVONDT/1jIwYX09ziZ1riQYAxm6L7h7rlXsSeZJbK4+rXGPX54gPEQKIfY97YCAQE8SH+i+S3OQwuOyVvVIr4ilIsLnDgRIaGU8/KU5Pl+fjQAtezB1lJul8H59noBZxoYR0dNyiomHN/6cmUafr/jVJfXOxFFGyoPJssTF7UDZUKZgNw0d2pWvgAPjZau0fcl7Er0KLSvbSyudZnGvKGUWu0GHtDw9mhtdtw7aGRLG82lD+h+KE1L9ozV3mV+UFFKCO/6fyEVEJj5zTA4MNKdA/rYx2ghzoAjdcJl4VinwDfCx6lzNJQzIRnQHoInhbB5TqdFIYLBH0IVCVUoxMuRHLPVUWn/FFi3Nr+Mv+8brdKpwGS/zdJHq3dmo1ANNE3WMPxDRF+5YZR+xz8lOORHPzUSU/bY3h2fUbjyCClSSIwv6pB/SneiJOVPyco9CGeb+ECIxjf5T0dX6ZEd+qtRoposz0ibbua2uwQgQhdGs0pUqOQs2MR9zLT71Lb4gmmeu4Akrnrp/VzKfXvbNzE2WAKa2FJp418N1nIocns=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(186003)(2906002)(2616005)(6506007)(86362001)(7416002)(41300700001)(5660300002)(26005)(478600001)(53546011)(6512007)(38100700002)(8676002)(83380400001)(8936002)(6486002)(66556008)(36756003)(66476007)(316002)(4326008)(66946007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eUwj3BZx3CCYV+C8IyoleadqwQvjHphRkRlIYt9zU6dKkPp2MEL8Xi7oDXVr?=
 =?us-ascii?Q?RNzR75jKi7yNjC7Ku8bl+d7U4LziLL56hNNUgsLhOLj0z+FOlw97QrlD0N+d?=
 =?us-ascii?Q?LQ1ImS2+OB+t3dQEksLTBXrPzcWcGGxrI3uqGuCb6wojGVC77NRLhQQqDW5/?=
 =?us-ascii?Q?CMx0Rjlf9k7Gm3Jf747D0gccY/gGWYJj1PYgLvE5w9XoRYf7jgHLopoFQNk7?=
 =?us-ascii?Q?lslDyrIr5BBxj8nnOrEtXc4Bibx5pn7TDDNbOOQHibXe8zKCh2G3l6JTuula?=
 =?us-ascii?Q?PRCoPhXQWSbk8SC/e6Qir05dtMfVHOXg5NaUzJ8UX37QeqieV9GufHntYK3G?=
 =?us-ascii?Q?j8R146IYt9BQdQNZ1IdLn79bk2rA/dpzEUse7Qq0AXvXqTus+OZOW1h5VHCS?=
 =?us-ascii?Q?kZBDFIkR07hGn9od3Yu/2gOPM30ptXNsBTZ4+Tu366OtkSudUx50XzsoJbK5?=
 =?us-ascii?Q?0LPEz6rySnnXpOSQWXfyAsFGnwPhPa2DKUYCpncgso7p6sYJRHopwO56kv2T?=
 =?us-ascii?Q?uA33lcWBfrFtka9Tffpy1KnuNsqhLyY8CILl1zSbkZ1OpYgXTyJmpk40bau1?=
 =?us-ascii?Q?/Vcxao5Te2N+ILkSe9YclbtjqA6sz8Xjvf8B+KN/8kyjSio/+0QyRorsMjxl?=
 =?us-ascii?Q?9XFiHsJGLrtwYKzSJ9sSI5XzTm4XyPLYfFnc9GooWkqhHXFtJnzGGtA7BjLB?=
 =?us-ascii?Q?TLNFW23PHfL9ZDbb02SRUEdZq6veEVXgOS/yKlvlDAD2Wx1IWMi6IizRToJc?=
 =?us-ascii?Q?xXMBegDSGzZU1lp3GE/LrwvZd9digcr2NPVbOAY2ojSHtQL8RN0cXL1VWiOr?=
 =?us-ascii?Q?8EzGOePMPqV3GdMoqzqZ4XNUm5cZr+HN2K2/cPA2m1Q72EdRjLDarh2yf6xX?=
 =?us-ascii?Q?HgMRblTzkgSMHpTViLF9sy7aAk8+UooB0EMC6v7de8XxOA2yKKos3kl0dtDk?=
 =?us-ascii?Q?hKeJ0AqciWyIhQ4i/l/kC0zEiFMK2xd11IfCHXdn6btIEtUC6aTlzXqDp5SK?=
 =?us-ascii?Q?Z9lxl1vwk4T0RMU2mxx+eX9/EMYXsKtEOpdCpzALBKF+1SUTja6FIzAnG2aF?=
 =?us-ascii?Q?Q38qRr9wKT9XI0mvtsynUWusL6fiWEUbWqdp8dM41Y2tVaATZb1HkEwOFl4S?=
 =?us-ascii?Q?vgHiU7A5sePcNzKDlWrwPPVPCZAOAuAFBIRfsQpEdwxlE9HwfoOUKavuj0wB?=
 =?us-ascii?Q?oojvX8VyQZZyM76zXetrvRdZ4QlLGEOjWtZWndQ4GoQ4QmPq+pmnX2e66xs1?=
 =?us-ascii?Q?8k0fK/ONyqY/Me9EPx+t+W/gU7Ro5V3Z/4WkO+glaOzenHC3M7Of4I7h9ZNA?=
 =?us-ascii?Q?EbfPYM6Qz9WpW7bg92RMTVvsB/sXseAsfl7aMFsf87gXPprTE+AjtPErpfrp?=
 =?us-ascii?Q?AEWmtGxhH9qnUSMgZU8ZkO4uG/aNL6U2uNUbxwPgDjYjatFQ3EfwW/nM0rb4?=
 =?us-ascii?Q?FxOUZBOvoYkKUW+pQShguGJKY233B10KKL6hvi2q2BE5dT2i2mq0y8Yk5UGO?=
 =?us-ascii?Q?b8Fpzu/cDDMGSxD9CrdTMSw29/wi3caZZZrMpYINpXcW7ps4s/tIZlL9Bnmh?=
 =?us-ascii?Q?Rtozv8pTdaEnMm5ZdHr+iYZTZsh0r53VN2/Ivyem?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef78ef8-38d6-4fc6-2561-08da80699b42
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 16:00:29.2945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PbBQJ/RzNprEUn0QXStw+m0au2ncgKLpjsDtrHmrjHp2ua6GgSDNw9yoy7m/Ojq5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5932
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 03:16:11PM +0100, Robin Murphy wrote:
> On 2022-08-03 13:26, Nipun Gupta wrote:
> > Devices in FPGA can be added/modified dynamically on run-time.
> > These devices are exposed on system bus to embedded CPUs.
> > 
> > CDX is an upcoming bus, that caters to the requirement for
> > dynamically discovered FPGA devices. These devices are added
> > as platform devices where fwnode is created using 'software
> > nodes' in Linux framework.
> > 
> > This RFC targets to solves 2 issues when adding devices
> > dynamically using platform_device_register API.
> > 
> > 1. It creates a MSI domain for CDX bus devices, which can
> >     discover device ID used by GIC ITS without depending
> >     on of_node.
> > 2. Since these devices are not present in device tree, it
> >     creates a sysfs entry to expose the compatible string.
> 
> Isn't this pretty much what CONFIG_OF_DYNAMIC is for? From the look of these
> patches this thing is still completely tied to devicetree, so why reinvent
> that wheel?

+1

Since the v2 was posted, I strongly agree with this.

The idea that "FW" should somehow provide the FPGA DT components seems
completely backwards. The DT components of a FPGA should come along
with the bitfile that is loaded into the FPGA, and not be part of FW
at all - unless FW is loading the FPGA, then FW can install it in the
main DT and we don't need this.

OF_DYNAMIC or some other version of it like this CDX, should be used
to patch in an entire DT for the FPGA loaded from the filesystem.

This is important because of a lot of useful use cases on FPGAs are
things like I2C, SPI, PCI and flash controllers that rely on DT sub
nodes to be functional.

And this explains why this is creating a platform device - because if
you have a DT node and want to instantiate an OF driver for it, you
pretty create a platform device since platform device has been turned
into the "universal device for OF nodes"

This CDX thing isn't even a bus!

Look at what cdx_bus_device_discovery() does, look at its YAML. There
is no halfway sane bus here like PCI, it is all driven by a DT. The
code to actually get the DT is all "FIXME'D" out, but that seems to be
the design.

The only thing the CDX does is provide some fairly hacky support for
mapping the stream IDs and devices IDs in the FPGA fabric so IOMMU and
MSI can work because the DT fragment it is loading can't be properly
connected back to the main DT due to how it was loaded.

Jason

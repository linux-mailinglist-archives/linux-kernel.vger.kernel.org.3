Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2B74A4F35
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 20:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359194AbiAaTKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 14:10:23 -0500
Received: from mail-bn8nam12on2079.outbound.protection.outlook.com ([40.107.237.79]:1120
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235245AbiAaTKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 14:10:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8eVK/eumEDbr5hXRxL0E3YUwK09vkRdit7weYPaCCo1MYEFRu1dE3H4jQrC42JykHqAV3kNfx+MaeebbyOO30ntOmzZpfHGswwuDAD4cGeVGPq9YkYhdI3gfKV9dKuGSgDM1is/eF/hZVmO/sXjxXQEQ9SJ8Yc7dz1O26oMDkfpi/CwCdnj7Z7JABLXqcRin4LtQOzAjreT09DuO/nLnX+V6z1OmBMylaoUoUzw3hN8iuc0ae5Is63canj3vLdGwqMAn12X93pasg7rLXtLMHQkbyL7m5yiU/Eg82vPkLZlthORF8yXKbX3NvmwgAPm8OKhYUnzC63FI71+FsyYcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYxjHKO1/VvLeg/W1h+usMVYXA9tiEb1/bwxDkcbSzA=;
 b=fRjeZ8RVK3GdL9JELYcI6rKhEdVSYkykEo9ccz8192fjojBBoDwWvHktIdm2n+yKVhtPpG5JOfhENB331v26AobJ+Rj0WQ2LzAhhawbibYVCh8WFIeBhIijfxVCbVIIIw2fB7dfm5L/7970E2CEHHQZx3XE+UNTiYOj7FR6+0/Eq1J/gc4Ysv0TpjrqTWKOPf8MHSZwTke/kGm+aLJcofAT9ZTEg7BQlwQXBdhzegX5EXSjUe4WpCTF6tI2crHK3eEGEUO8KFujept9FYpIYAUHzCIS0qMzS15gunkn2UYj5KzvC+Cao5hTh9X65fkddfKpOOQoupFP+C42W5pm9lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYxjHKO1/VvLeg/W1h+usMVYXA9tiEb1/bwxDkcbSzA=;
 b=AE5qnxll2Uo6PqcVkOwJQ/9x36bVmBSO6cpIuM9bcp3vvZY48m2qUFgNXUmFHUt0atFbhmXGAGRawAPICdOrN7PKtkbcgI0pnFqqDoNQB+x4F0G0dD7yLsiQYUJHmH5nywuINz90tNsGk8a768wQcWBkameM32DVnWqCfv/eKmHtG3lJIOpMUzg5N1+YcIW66+7UtLnRSkpiJcAqfRvohImJiNzdYGFEGPypQQNB5uYDbbASWY5NMhuJg8T5s0ckmKTaLvhswrmoSX7sjrMW0Z+m1kVFSRgFZb0KUeN6JUdReu0fBSof+H7ItemdwF5IJJfJEIpy1BOQHR9q7QcP5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4209.namprd12.prod.outlook.com (2603:10b6:a03:20d::22)
 by CH2PR12MB4295.namprd12.prod.outlook.com (2603:10b6:610:a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Mon, 31 Jan
 2022 19:10:20 +0000
Received: from BY5PR12MB4209.namprd12.prod.outlook.com
 ([fe80::35a1:8b68:d0f7:7496]) by BY5PR12MB4209.namprd12.prod.outlook.com
 ([fe80::35a1:8b68:d0f7:7496%4]) with mapi id 15.20.4930.022; Mon, 31 Jan 2022
 19:10:20 +0000
Date:   Mon, 31 Jan 2022 11:10:19 -0800
From:   Saeed Mahameed <saeedm@nvidia.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Leon Romanovsky <leon@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: linux-next: build failure after merge of the kspp tree
Message-ID: <20220131191019.fpa5sn5u4kuov5ub@sx1>
References: <20220131100954.74a2034f@canb.auug.org.au>
 <202201302002.41A8DDA2@keescook>
 <20220131155932.3f88ec71@canb.auug.org.au>
 <202201302216.97F2691@keescook>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <202201302216.97F2691@keescook>
X-ClientProxiedBy: BY5PR20CA0027.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::40) To BY5PR12MB4209.namprd12.prod.outlook.com
 (2603:10b6:a03:20d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7396d35-ebaa-4a91-eb4e-08d9e4ed535d
X-MS-TrafficTypeDiagnostic: CH2PR12MB4295:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4295714B3BD465CCF26AA842B3259@CH2PR12MB4295.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: orb7GJFM2s2z3kwZwOd6/4uSCDEMsXE/Iyg83pGo8GtS7wQNCzKUJDV/S+bONrNTxP0NXmpDuHGrpbgh2LgoizyzpToTIsAHrP4SmsMt42l6uiCI/ioTfYJIfx36iBA9PqXzhIKEFmb8KTkk2ZvQzL9MTblUOlJjTuEqIJn2Tca/gqmJLnmhWCSFWPblfaKmfnxq+hVYfoovRhMZAWdIsZlMhMwPOAw13SffUMJNjTbEB7N8sw0TsZ+3yKMmDxviy1cS1IPL0JcwKz3Abk2FqXuTUd97vx7gj+CFCJhm/pejlr2VfnY8eqdmXI/T6/8X1DRMXDn4vifEM3XVZObQ6vFZlbw2GS7SZA95s++VzH5xeBRx4z9U67Krv1cObqMpsVl79vhR/HQS7vlJ/IdZ2TPqqcCYUwkJOuwhV5Xo+jblKNZD2VSFbasyVB7Iau3d9jeVdWpazA4sO5QC2wBtoatEcCqfS3vs69M8f+WwrZJiRx0Csa5ZmmwkC+uksXaM5tPAfjiJBtg2WQo0/GrEW7oesmdxdRA995NHR+Pg1/ZcmglSPSphLxDkO8rc/WElA942ZBcvJqYAmAqYlx3FUBevc2gJvn9RSr5NJFw071mTcjp+CkQAhMQdX0RuHQ52lnpYdOhiYmyGJp7gvoXPQiut07ITrJgJUMTM0yHwNbTddJAd/frLWJNT28MUbMs4xF+5WdWbO3UreHOMHTG+FHF7oEuETEqwLWg+ycVLJbIXSTs1CKbGc2/FzhQGlAPeP2jEwxc7aYjsFOe4Ifj80CjJO0M1lTsTFkT07oAZ+0vkoFmXSMnz/YQDJRwSF5Ki
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4209.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(54906003)(6506007)(6916009)(6512007)(9686003)(1076003)(26005)(508600001)(5660300002)(316002)(186003)(966005)(52116002)(6486002)(86362001)(4326008)(2906002)(8936002)(8676002)(38350700002)(38100700002)(66476007)(33716001)(66946007)(66556008)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ii2zBfoWj9Obe94wvRebNYYZkQCpL6VdkD9UmzBzG96DxvjKMRaFJHYqYMi2?=
 =?us-ascii?Q?Yvp4nuGvBcQmPPg//cnipNdrZkEIuKhnz3KFBd4wqCXIca427NGygS+FTowb?=
 =?us-ascii?Q?vRAfM7RwO+0ectrvTcYhtQrMcVAU05ibspumqq/ZaLkFpzNW/zQa143vWHRd?=
 =?us-ascii?Q?jyLObDLxo8DjEgyrDjeXSRbq/Th9HS0f4JxcFnZFeqP75e3dvmAKCP3o0wxH?=
 =?us-ascii?Q?Ttmtzfs/0bn2DbEEqvd5FMIIqCEfSIx7LX0I26GVkRiNfbiI3nuS0U1jHS5O?=
 =?us-ascii?Q?BWNdpNkaXxOqSDFpi+xBgYTa1T0ZBY0Ph+xvrCNNcNJhJ22YZzxcywcNd6AK?=
 =?us-ascii?Q?BlWh3K7RdrU52FFT2O4+sP4hCxjHU7lF93xAJydlrXqiOyeb9g6lA+Pm9eaW?=
 =?us-ascii?Q?f7fYy3qqS7X3ieYPXZt1uInuP0rgAHk0WQFeyJpQCyCTBDR+AsjFoFoGpsdw?=
 =?us-ascii?Q?iKLCOqgA9CnVkIpBkgZnQcmX5RwoJQ3HpN6BGF27j1zPapBhkmLPcztetRJX?=
 =?us-ascii?Q?CrpLfNE+ChGO4Rz/ACQpQurvK6OQjC+VBwRc8uIXNIEqUzXoEZi1WO/v7IBb?=
 =?us-ascii?Q?P49gM/SIHAhDxJ7mX368JUaVb/fhs7YqEw5Sd/pq75BEdf93KlKASjDnfsxW?=
 =?us-ascii?Q?gQYcTWi4nw1n3isS8zUvD4cDikzK4y1S0fYYMvMDn3dEDJHDu3ipblJBjKqd?=
 =?us-ascii?Q?QtmVuuKreaTaLs4PX33m9Rglwh66C9FoaR1PyR1kZsTUIMoZKAsQIP9ffj5T?=
 =?us-ascii?Q?aIBm/iiFjficjy0ku7WyW/zJQhcnz6+YasimxXytwDfl5NqblsgQuUAxCA+u?=
 =?us-ascii?Q?2Yn/MBd7DKN0iAuojnc3oKanregBpIPpX2qvakXTU2IkGuJbc7bA57vqMH3W?=
 =?us-ascii?Q?UPQy84yKAB+eAvPm9X333QoxXZvc+kC5BfbtRylNmp26o6zgf2TBGMPNpbMp?=
 =?us-ascii?Q?ww5IUNxsPHhekb1VXKGP49yviNvla+rfQOEXiRJFIIn+tlX5D4CvsQ/TPuHq?=
 =?us-ascii?Q?07sqjqBn0giUkAsHxTCRs9G3/xdbmLv8ERF5vE93Zwh1b/+/5C3jIVyWT8We?=
 =?us-ascii?Q?r2JyVjvikq8RwAEY7nQhpoXZ2kFAXgtH2fKLY5ey3Muj6aWXUyAeDMMv3LZp?=
 =?us-ascii?Q?lPwp64BKTzOjVF8dt1g7cQ4KkN/0rdIr3lIe53etvoZdvtQ/M8VZonKT9xvK?=
 =?us-ascii?Q?kLIFwUVjb2+Bot/gc2m/FJpPaDz7fIcxETswOmr/RWTXklmL30WepxnhwEsM?=
 =?us-ascii?Q?7KbWVWoYbp7fwfpTYDtaLvhivcGe56rE9SS9jw940HDAJGDH0yabFi9QVDjt?=
 =?us-ascii?Q?HE4fC59AXvBCWEDSLizZcu+sUXThr5UsEtGLCYm2GZTuw5TWVv6SmhkutSLK?=
 =?us-ascii?Q?IcimMZxB/+jlAAkmiQom4gSt8gISPIlL6gJMI8lu2DfAyEasZ+/3vrbjijX4?=
 =?us-ascii?Q?Id2mgiTs+JMx3KYFD2N/mia3a666iEnauYEXzR/sdRIU9sqy8dgAl1aquizD?=
 =?us-ascii?Q?FnvRqeXyCOUIxMOWtM9N9FdJ5EaXjqoDrNow6bkp25N7L5MsSQalJ267M8KP?=
 =?us-ascii?Q?42zNioOLrhTTSNZ4FSTfgFvS72cUz9DAAwrp1JXU/dTR5WAAPuUbWMU7dZao?=
 =?us-ascii?Q?rf/LVVNhUBU1TBwNinUu5qU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7396d35-ebaa-4a91-eb4e-08d9e4ed535d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4209.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 19:10:20.8244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KN0zakcUHAH4nN4vLZW7qHiV7Da7BYqIL93X5eBbS0zpi5niIaLG8AG304RMu43nWyGsJzV6yuzT3h+ymLqrSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4295
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Jan 22:19, Kees Cook wrote:
>On Mon, Jan 31, 2022 at 03:59:32PM +1100, Stephen Rothwell wrote:
>> On Sun, 30 Jan 2022 20:04:00 -0800 Kees Cook <keescook@chromium.org> wrote:
>> >
>> > This should be fixed by:
>> > https://lore.kernel.org/linux-hardening/20220124172242.2410996-1-keescook@chromium.org/
>> > (I was expecting this to be in netdev by now.)
>> >
>> > This should be fixed in:
>> > https://lore.kernel.org/linux-hardening/20220124172028.2410761-1-keescook@chromium.org/
>> > (Again, this was expected to be in netdev by now.)
>> >
>>
>> yeah, neither has made it yet.  However, it would not have helped as I
>> am merging the kspp tree very early so that new bugs get fixed in the
>> trees that introduce them.  These 2 are in Linus tree (for a long time)
>> and so it would be better if these fixes went int the net tree and then
>> Linus' tree as bug fixes.
>

I need proper fixes tags to submit to net, can you provide ? 

another option is to use a shared branch with those fixes and pull it to
both net-next and kspp.

let me know what option do you prefer.

-Saeed.


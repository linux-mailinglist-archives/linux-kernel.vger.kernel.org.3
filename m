Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268F757AE0B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240272AbiGTCai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbiGTCaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:30:23 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2139.outbound.protection.outlook.com [40.107.220.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E039D4BD2E;
        Tue, 19 Jul 2022 19:26:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCg6fwTxE9XA1fRMV6aON3TRzZyvjvTbivRcS667XzUwVA7buToveska7VRqT9OMjP1v3Hm2bEylFAeleZzNujbq5zRVPq35vXyySrcthDBtJAwG4MiC/LSgXvcjd/jqt6Q9C+B2JemPWcbNopuJuGrEDNq7vmEsKH9UblYIlbH6TrK+cTM6lhPxwxLnWTildp4Y2/ZoBu1WKhE7gMDep2dZwEFQV6TSzRoEljoTlrCYKkmcdu1ASNOZbLc4SENUuv8hTxsZGpz3T6sOKhTGUv9xcErlH6SRfw4kSk4+o0p5b6OIjf/4m1IJJwbW1eJypLPupkqeWJFKFYM3ImFdPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laCfadQB3euTq+yhu2dfML8pWcNLaciEdgnGgtINyhk=;
 b=UKgPYpcDzM1X1TLKiSrU0/mAfrUwVE2nJiXZIIQjr/hQZ3F8OanuBowFLhpo8HGL5SDXPpDc1jus+6Ce268KKzMZRGDZLm8GWia4Cf4WzogBq+UbOyJmFB5XuxrTSUY4Uq9TZMUT7bKxJb3PGrE/mprG1WzOLOMHzczJXOtenPv2TGB/8wJ7IlJFHCxcGMPfGHJGvxm4ahosf38RAdF2wSbWL90Z/J6m286t9HYtALiB57VLX1gHj3ZvP/allmXs78o2B4ag6QpJLjarD/0jM2sefv1B+9BpdQoumlxQ5yDwRr7Y5h6iEyo78voJIiEnlQkE9sEeTaxnwqCN6QcqXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laCfadQB3euTq+yhu2dfML8pWcNLaciEdgnGgtINyhk=;
 b=qX4l7zaUN0Wbv4ZbMj64iWU0Yb93U0geaYsxINt0XIaDlbuK5nVKezRoJQs61zcFoQJAHDGSpyCj2XiaoVc1mz0ic/5FPELpgirGvaNOGJdcFXE3iBqfpcz7UCjbQfSjquR5E4rI8iOfWrkOshpajmvt5DtWPZWs4NO4WW8GxSA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by BYAPR04MB4359.namprd04.prod.outlook.com (2603:10b6:a02:ff::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.13; Wed, 20 Jul
 2022 02:26:16 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::f02d:f2e:cba9:223b]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::f02d:f2e:cba9:223b%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:26:16 +0000
Date:   Wed, 20 Jul 2022 10:25:16 +0800
From:   Xin Ji <xji@analogixsemi.com>
To:     gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com,
        krzysztof.kozlowski@linaro.org
Cc:     Bernie Liang <bliang@analogixsemi.com>,
        Qilin Wen <qwen@analogixsemi.com>,
        Jinxiu Li <jli@analogixsemi.com>,
        Rob Herring <robh@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v20 2/2] usb: typec: anx7411: Add Analogix PD ANX7411
 support
Message-ID: <20220720022516.GA2328368@anxtwsw-Precision-3640-Tower>
References: <20220719024704.47395-2-xji@analogixsemi.com>
 <202207200429.z6HHJnIG-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202207200429.z6HHJnIG-lkp@intel.com>
X-ClientProxiedBy: TYCPR01CA0134.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::13) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7bb8530-1424-48d9-a18e-08da69f738e3
X-MS-TrafficTypeDiagnostic: BYAPR04MB4359:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SCGz8qWSWEeWAeJbbCyKMGZWQgXRV7nfnPIK3qMQ3jxKF4xQIGx3vA/zrptsZPLUcLsuJmrDxU/zu6236D9D72A00sv3rv2H8135QbYBdwa0O9Mxzjp4AjdamS2n7W7SBZl3NZFeo91+dmTk2umtvQVIbbz/dDOB+1jEZKZPYHGUhOxDqq+huhPclVwoF5r9fY7Hx63pm7Kob87ncXaAOZB7KRrK9lNzdjh120X0k+PtPyfQPy4QDgwFp8j+8uDjGeQj9eX+lusT5pNndGrpMj0D7UowjDw22/z5mLrJ5v1QEcdCA0hVkPhp55mq3XLhpfXc6FZA0/TfOHJisyylnsjLMGFr+8nFcwx6krsH5A8Unr1G1TM1D+dMEymSVJD09lz7ALg0PSCRtXza1KV6feEKyKGW/TE0ICBL2tgGQOXYCE4L3iMR1A0eS3KcQdouxqUo82UBClUKhzWwVqkWnOxC3ndalX5dIRpGQoGAt5XaIPwA8GVxU6e6qbRs6im6cFMhBfRt8Ugz/rcTEO1gQ7wFkRcKf41md7g7zHxvvoRcsygjGX8Yi9g1N14qD63jAfWBfrM5DEJ29kILPwzxzs462ItoaafM7S5b6uA2uNYgMEndYd4HMKmJmUA94UwzBGWTAq3i3+FsJL7DE1fT5Bq4sSMBd9W7+u5x9lGmiSxySghJSBgFOjzkSFUhqM2vQoBeS5U3rGFL1xdcu/uYZ3atSf+MdZxO0c8nuG/Ix+IInz/aAVSenRF1ZucbytKZDJBl9o3yXHCeKjGEuRSryQowEjM2f9QxRr45LPizO8pTBLVGyQ0L0NdJsJl9ecJHSmn/0KuyREcuxITDvxl3Hg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(136003)(39840400004)(396003)(366004)(376002)(33716001)(316002)(83380400001)(45080400002)(38100700002)(38350700002)(4326008)(6512007)(5660300002)(52116002)(478600001)(186003)(2906002)(966005)(66556008)(41300700001)(1076003)(66476007)(6506007)(8936002)(26005)(66946007)(33656002)(54906003)(9686003)(8676002)(86362001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hbrYRUyfsE6mR5aaDPoxxd4KcnmRSfgRYkE7Jr3XtRrfyjEy3F7GwYtXXAOS?=
 =?us-ascii?Q?Yb+ZxlKFMMugR4EYFPHfguuVyqx/4UxiutbJHjsizn5PMZcwX8ZfWJBtyhep?=
 =?us-ascii?Q?IJJy2v9PNxKOMvEwREqh8ZYkdW+50WO/kXr3Bk9qdfNKFx37daK7eTNvYI17?=
 =?us-ascii?Q?YkZmnqmr/lwgKXfBnKf5euK0Sla425XS0x3NoRizDzL2XirUkPBJORe+VIp6?=
 =?us-ascii?Q?QcWBDlcGFwJiLX7PRb5nvu6rUoache2vymoPXoTx20FhCL77zNHdyoXWMSc4?=
 =?us-ascii?Q?PUsQTBQpdr5/JutVePUqJVg8nO60aVWx4dp7EEljFoxhW25IwlhSheRBJ5dw?=
 =?us-ascii?Q?hVQQuco+PpAin2OpyeYSRXxKV5ea4ShegzjAIgA9uT1pZwVNYatLfzJxNMXw?=
 =?us-ascii?Q?qhkyYmUyzy8EkoorMt20x+XKOpZhRmWLpzmt13ScyzJOG59Rq3YWRDmC8Xzp?=
 =?us-ascii?Q?xMKRicKpbHQGzPLpXzuTELYisawmGNyyPDeaFvOYLotLExiA9VWgA9c4sB6m?=
 =?us-ascii?Q?MUVisfLJ3OuJ9Yl/dbGbFXZAPV3ETZlfyqQYLRQyyOIQ2ZQ4HjRMB0QlNcIl?=
 =?us-ascii?Q?dI4r3PxvtBRPoxEUt89oCxoVX9j0Fxgryvz0e3S+wW1gaQeDGJudOgdB1Hzz?=
 =?us-ascii?Q?k6OZWxny/VWNt/8cjx7OxlqFu6aqCZL09pkSX9+/HSX35gNjhiOZlgUtNfnK?=
 =?us-ascii?Q?cMe0hBkyRp4Q/oibNolgsEcIdOcUTFuiuR4m5zv0bVchQ/kCAgqFoBhP1e8m?=
 =?us-ascii?Q?3Co4O1ayEakEuYpw1WKA3q+NLp1sda/ojBv3TVSVifuRDIOlh9Q9F6wHu4p/?=
 =?us-ascii?Q?4tWf5nfYeYX5X9fu5PlzfOWcrDcA56IvQlvETMzy0lfNIhwJCUYF0gfnRUZ4?=
 =?us-ascii?Q?u+Q3iRGZIJcc/m4wr8b/D09RHEaJ24ZbNDNv5eXHWMKp/3pMiDKhzYLDn7XI?=
 =?us-ascii?Q?UTm530S+YOLl0nNbjAV/lWYSDEAvUasWir8D6Oq4eCBkr5Bftq0NKuRdtX6x?=
 =?us-ascii?Q?6hjZCc0IVFfsezeEcx03RqT4XrEP9amrO1ox2uXlITyp8MNG1IxLhE7Ecyb+?=
 =?us-ascii?Q?Z4O6m/uwLm6tS8OD9jP1M/LvOfQoZpzhBsCdymEP2ohkvQM+hD7iiBQFoFNA?=
 =?us-ascii?Q?W+KEVOEAGj6n+Vr6KBFBJusQHXlRF/8EU6rWSp/4OjHWia9utfcieqPQzRB/?=
 =?us-ascii?Q?Qdn4l8PwQ2DQHYjYyEsCKQJ73eE/gXD69bt/UghmBJier3/AiyOT/cjd/7d0?=
 =?us-ascii?Q?uwrKxmIEpYEaCpjcp94SexHv7BjzOikxuLfhsJPmOtlGgomgPQY0FuL78vJ4?=
 =?us-ascii?Q?Rz5HnbtJjbLSAe2c+PAKgGAiRtI8T0c2G4M1rdlG17uIiV73Qb1BcvspeFCA?=
 =?us-ascii?Q?W7dej1+3oVYeSeMHUiK+NLxYSgQLpEo9AWspNUGXx0acbOIslBaxnSQMG2C7?=
 =?us-ascii?Q?rVUIh5JgZMlyNzkclH6knCoHtpIynPMkNv9YjyriYDiqjuJ/DJYzZE3o0AZz?=
 =?us-ascii?Q?MRh7WzcWCawAx8saZ89HGhCWYOkc6Wp55OivPHBGPf6Bl5E/k7m5DYL3dzDA?=
 =?us-ascii?Q?aVCP9N6fLUMpJBwdXJ6eQAcXu4tSTKTPtT1jnKAs?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7bb8530-1424-48d9-a18e-08da69f738e3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 02:26:16.2532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EuYS1utiWF8tjo4YrnE1C9BQWGWdwvAuYfVkXyQKsEQnhfxj5xb6vtWrKHQ18ALV0Pjhr1ejRlK936X661CGAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4359
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi greg k-h, can you please help to fix this compile error? This patch
depends on "usb: typec: tcpci: move tcpci.h to include/linux/usb/"
patch. In this patch serial, not include it.
"https://patchwork.kernel.org/project/linux-usb/patch/20220712090534.2783494-1-xji@analogixsemi.com/"

Thanks,
Xin

On Wed, Jul 20, 2022 at 04:59:31AM +0800, kernel test robot wrote:
> Hi Xin,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on robh/for-next]
> [also build test ERROR on krzk-dt/for-next linus/master v5.19-rc7]
> [cannot apply to usb/usb-testing next-20220719]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://nam10.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit-scm.com%2Fdocs%2Fgit-format-patch%23_base_tree_information&amp;data=05%7C01%7Cxji%40analogixsemi.com%7Cc9949cf707b24c8983d708da69c9bde0%7Cb099b0b4f26c4cf59a0fd5be9acab205%7C0%7C0%7C637938612461856216%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=NE0PaKmrkIpr38yCkK5PnP0bU%2BjfyCZh7ETFGllEeFg%3D&amp;reserved=0]
> 
> url:    https://nam10.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fintel-lab-lkp%2Flinux%2Fcommits%2FXin-Ji%2Fdt-bindings-usb-Add-analogix-anx7411-PD-binding%2F20220719-104903&amp;data=05%7C01%7Cxji%40analogixsemi.com%7Cc9949cf707b24c8983d708da69c9bde0%7Cb099b0b4f26c4cf59a0fd5be9acab205%7C0%7C0%7C637938612461856216%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=%2BYrQXrFwArNNfuzBeIn0NwkEEaZe83IWOuWcbdDJeR8%3D&amp;reserved=0
> base:   https://nam10.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Frobh%2Flinux.git&amp;data=05%7C01%7Cxji%40analogixsemi.com%7Cc9949cf707b24c8983d708da69c9bde0%7Cb099b0b4f26c4cf59a0fd5be9acab205%7C0%7C0%7C637938612461856216%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=dQBVaf7Rz%2FBh3BCOFaroRhcMxscfN9NQqhqT7oIyAq0%3D&amp;reserved=0 for-next
> config: ia64-allmodconfig (https://nam10.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdownload.01.org%2F0day-ci%2Farchive%2F20220720%2F202207200429.z6HHJnIG-lkp%40intel.com%2Fconfig&amp;data=05%7C01%7Cxji%40analogixsemi.com%7Cc9949cf707b24c8983d708da69c9bde0%7Cb099b0b4f26c4cf59a0fd5be9acab205%7C0%7C0%7C637938612461856216%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=wU8resq844fF%2B5uH3yV4UsZq6e4AMJ5RZPXA1BkSjr4%3D&amp;reserved=0)
> compiler: ia64-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://nam10.safelinks.protection.outlook.com/?url=https%3A%2F%2Fraw.githubusercontent.com%2Fintel%2Flkp-tests%2Fmaster%2Fsbin%2Fmake.cross&amp;data=05%7C01%7Cxji%40analogixsemi.com%7Cc9949cf707b24c8983d708da69c9bde0%7Cb099b0b4f26c4cf59a0fd5be9acab205%7C0%7C0%7C637938612461856216%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=TbXu5vgbQR8Ue%2F7H79IBcMnh3M7BgZ1lKUvJFg0661Q%3D&amp;reserved=0 -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://nam10.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fintel-lab-lkp%2Flinux%2Fcommit%2F02d4e6d59ace40d44e1af982c06f9bb7f37038a7&amp;data=05%7C01%7Cxji%40analogixsemi.com%7Cc9949cf707b24c8983d708da69c9bde0%7Cb099b0b4f26c4cf59a0fd5be9acab205%7C0%7C0%7C637938612461856216%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=5naf3AhjQ6%2BdJWz6gE9H1j3frK62fOXq%2FsAC0uHubhM%3D&amp;reserved=0
>         git remote add linux-review https://nam10.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fintel-lab-lkp%2Flinux&amp;data=05%7C01%7Cxji%40analogixsemi.com%7Cc9949cf707b24c8983d708da69c9bde0%7Cb099b0b4f26c4cf59a0fd5be9acab205%7C0%7C0%7C637938612461856216%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=8rL58C2xpQe1ThlHmvFhJjY%2BQYz7OTxIncE3GXcbEfs%3D&amp;reserved=0
>         git fetch --no-tags linux-review Xin-Ji/dt-bindings-usb-Add-analogix-anx7411-PD-binding/20220719-104903
>         git checkout 02d4e6d59ace40d44e1af982c06f9bb7f37038a7
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/usb/typec/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/usb/typec/anx7411.c:24:10: fatal error: linux/usb/tcpci.h: No such file or directory
>       24 | #include <linux/usb/tcpci.h>
>          |          ^~~~~~~~~~~~~~~~~~~
>    compilation terminated.
> 
> 
> vim +24 drivers/usb/typec/anx7411.c
> 
>      2	
>      3	/*
>      4	 * Driver for Analogix ANX7411 USB Type-C and PD controller
>      5	 *
>      6	 * Copyright(c) 2022, Analogix Semiconductor. All rights reserved.
>      7	 *
>      8	 */
>      9	#include <linux/gpio/consumer.h>
>     10	#include <linux/i2c.h>
>     11	#include <linux/interrupt.h>
>     12	#include <linux/iopoll.h>
>     13	#include <linux/kernel.h>
>     14	#include <linux/module.h>
>     15	#include <linux/mutex.h>
>     16	#include <linux/of_graph.h>
>     17	#include <linux/of_platform.h>
>     18	#include <linux/pm_runtime.h>
>     19	#include <linux/regulator/consumer.h>
>     20	#include <linux/slab.h>
>     21	#include <linux/types.h>
>     22	#include <linux/usb/pd.h>
>     23	#include <linux/usb/role.h>
>   > 24	#include <linux/usb/tcpci.h>
>     25	#include <linux/usb/typec.h>
>     26	#include <linux/usb/typec_dp.h>
>     27	#include <linux/usb/typec_mux.h>
>     28	#include <linux/workqueue.h>
>     29	#include <linux/power_supply.h>
>     30	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://nam10.safelinks.protection.outlook.com/?url=https%3A%2F%2F01.org%2Flkp&amp;data=05%7C01%7Cxji%40analogixsemi.com%7Cc9949cf707b24c8983d708da69c9bde0%7Cb099b0b4f26c4cf59a0fd5be9acab205%7C0%7C0%7C637938612461856216%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=RAGaTA9DEcvfeMdWauI4T6zC5xMEogDdH6Rs7ERkR08%3D&amp;reserved=0

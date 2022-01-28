Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380B14A02D2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 22:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351403AbiA1VdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 16:33:05 -0500
Received: from mail-bn7nam10on2124.outbound.protection.outlook.com ([40.107.92.124]:52064
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346088AbiA1Vcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 16:32:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PEGMwh/vc0AbOjIn7Rg9gbgTaZB0ZZV+LBr1tGwlkc7JF8I0UFvb+4jVoRRV2NOYz3Lmqjox/38vf2epOyhu+1bYcJEPj9uSDiqYq0ZJVcdPGRGK3c6hxN6cr+XVmRRN+xNditbDX4nqKNWfKfbMT5xDDJQT1vaNfIrGtriG+OEwFpSOBYX7q44dq0KSCbE97Ql/haPrEGZL+VFCxXEQIOpgfMfdL32nu1aIOVgDkk9i7NreWx9vEE+yW0ITqNORypApO7VjJT7TT2TPLT0S0JGYkETTjdee9EcqHI0qT2Wx1b9mVj6yQ31C9qS7iPgFvlMQyytm6/VLGz/UgvR5QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MjEQqv/0yOk453wk1r5yG/NVzggoCHh9HEfAEQahJOA=;
 b=PsT4AIB8Phh1vGyTX6U3AAXsKkp2xTHCCowSl2laIfYePMiQsEPmqM5xnvVKJ5GxDFediktbCVg5QkgoVxtKU7pm6gLlSYKdz0UitwH61vKXVtuOxuL2eyguQ1Xj6EqC/l4lhmQcNaf8xqn8zDDLoOrGleugO0tuD12dBSqHwQ1JDqtIBktf7eXf6XyvZZKIsNQ3drc5yZ7WBh+vQDOzC1sQ8liHK44y+CHWO1LQ7MiyBi0oJYtoVMbLJuhKSiahiY7Vvy/IG866NnK+7G5S7v2CDDOawXlxfQ1MAo5ySocQEyKg7/q3o7+G/Ycq994UiMXce6IZJxQRMu1g1sp7RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjEQqv/0yOk453wk1r5yG/NVzggoCHh9HEfAEQahJOA=;
 b=zI4VGymNYULRL1ohbihjY6+UaZD2LjKNl12BfzoZg2pXFYskJJoxcheYkGUbzNPqGRdp8oSikKlrczzwyYB3wAwWSHySae75bnW9QGpnBngvXnmbt1TvyRo6tVJO9TL+8jO8+NmeFooiNKs+0tDeI9tKIwMYUsb3Fx1H/nArdMY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by DM5PR1001MB2204.namprd10.prod.outlook.com
 (2603:10b6:4:2e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Fri, 28 Jan
 2022 21:32:40 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::2d52:2a96:7e6c:460f]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::2d52:2a96:7e6c:460f%4]) with mapi id 15.20.4909.017; Fri, 28 Jan 2022
 21:32:40 +0000
Date:   Fri, 28 Jan 2022 13:32:34 -0800
From:   Colin Foster <colin.foster@in-advantage.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen.Hegelund@microchip.com,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] pinctrl: microchip-sgpio: Fix support for regmap
Message-ID: <20220128213234.GA1638668@euler>
References: <20220125161245.418882-1-horatiu.vultur@microchip.com>
 <20220125164659.GA31440@COLIN-DESKTOP1.localdomain>
 <CAHp75Vc71mnKST5aFGEivoU8ZhmmRf-ArNYVMb5Cf52jE8jetQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vc71mnKST5aFGEivoU8ZhmmRf-ArNYVMb5Cf52jE8jetQ@mail.gmail.com>
X-ClientProxiedBy: MWHPR19CA0088.namprd19.prod.outlook.com
 (2603:10b6:320:1f::26) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ff0cb88-1ef0-4db8-2e90-08d9e2a5b616
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2204:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1001MB22045FAF71A55E48AB7B3C3AA4229@DM5PR1001MB2204.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NrqaGqy4IYh66lTQh8suwu++M1oYBLfIHqZxu8yAMTNz5V4waDbWUqRGRevwXr9z8kFQD8azxOxa7nxEMr3igrPMuNYoKGyU4sIR3mnFzZdS2GaHhMLRx8xzqsaxZ8ZSOKnsAgipE2Dc515T9Y6OxCGeMO54cAFdJNPP8m3Lxk3gBrRBeApRUteq4A46lpyu15OUexpY0sDGmz0O6k3avIEwJuoJvrtDz3gGSWv2a9NF0Lp97Yr3G4/D7RU47gBRbmMOANrIAqUVBhzqG2/HuPwNdyN6Sv/DGgLqcPwU5Tce+BPp6yIg+zxhvQAjMCXkRCURXgsKnwSOg9y7DBNFTMBF7hB2dqmJF+V2YrHKW6elZ5wxRbx7W/G34vf1cxTXAKwZb5OLiJ8gkOUlpIOYsQawQLAR5zN+q19u7LFH9eE3Y5kbsxDjUWfL7VGU37Zs0rmxzzI/lkty6+lO/S9LIJPUMiDO4JDkhN5vDR7ZGUNrafyo0dpfu4IyHisdUQzAZkIAYcFMOEIvY0EZ+HiI1D4t/YoNNkUk2kTn9bmO8AOjSM88xRoemZl89Lr339eQgCDFwjwy/Z7lZPtww3K8rJtekm/nq0k7eRWAF2GqNo0sxD7HTQzOZ4l3mCUpBsPKlcGWzrkdcJ4gLSYzprpwRRyX1l/xmlZ512TqieRXj/LDibbqt8FIIkr+BCHDyNxcCNsXttxSb4pjWriSrz0THw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(396003)(366004)(136003)(376002)(39830400003)(42606007)(346002)(38350700002)(4326008)(6506007)(53546011)(33656002)(6666004)(9686003)(38100700002)(6916009)(508600001)(66476007)(66946007)(86362001)(316002)(8936002)(8676002)(4744005)(5660300002)(83380400001)(54906003)(2906002)(6512007)(52116002)(6486002)(33716001)(66556008)(44832011)(1076003)(26005)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PDpVP3sirj5JvKlbAbfvoA0xxdg4oTJyMbpx3jvwVlDAfyTUAkaCFwhThMCi?=
 =?us-ascii?Q?ep9ubSEq5KtUzdDRZa/0E8rws7r2vcdJ7APUcccUQIDoPrZeTu9AY/19zg3B?=
 =?us-ascii?Q?VDoVtcQVNX2t1IQj+qKjKapgcZSiqmTrI7z28ZZQaeU4q3yOHKhwOc/C2xGZ?=
 =?us-ascii?Q?nfXELR3RRt4cZ4q8TAQAtsYQVzMsj37cbyecvKdZsKNU3zjTT6hxmfc8bZ2F?=
 =?us-ascii?Q?2Ar2JhsRpbqfunfU22f9v4EeEPRajEB5AvFS4t/USRWJiu6xj9oQyQpyO3wF?=
 =?us-ascii?Q?7hFaSk2+oSqHTwSReeOtDnTJAp5Kk1ckvECciScsg7Rr3EjjEtgDa5YaP7Oi?=
 =?us-ascii?Q?btKIGv33qeQKNaRGxIrhRbsmAG2R/RSnymFr/4Z6Ci48TSdyQ4KT4wprQRbO?=
 =?us-ascii?Q?uIgELjNDEKTUuefQJ28HaUEr56Sl51HgMfGQTiAMBrczA3xSxpTLGQRxYj8V?=
 =?us-ascii?Q?LZYF1aeTSccCmQeGH9QtgARLzKaW5g4j5zqTZEJWOJpNWPqMNVKOmf35QJFI?=
 =?us-ascii?Q?CGZvpXgPKtAP5esdWSoPfgTxuB+UOpuFl96dNrnOOjCUkKAuZEg5ugkVV+Tx?=
 =?us-ascii?Q?RByEskNSLx9bqbQID24XECJwIAFKHJcrZpyWWUSU+9xZkN3GpEC5+ONCWVch?=
 =?us-ascii?Q?NLzhZNvXJ5T4FHV6JC1r/Ah5MQl1fUQiosBr/xYfpFXh8aVw0VZFyDeZipfM?=
 =?us-ascii?Q?kcUYkUAtOnzrozkdPZokn+EZrr3NHiyTDmucqxhb7vhSD87E4/Ug26neAFSR?=
 =?us-ascii?Q?5sfU6B1hBynEfjvZWamPlimm1skuyYfKhhR+i+VjP3O1z4yokqEGIHtg6ZNV?=
 =?us-ascii?Q?8QvAy58JFc5BdSOMpbRjI777DEx4b4/Wq+m4tn1tDM9yrbeK5yQnSg79snk8?=
 =?us-ascii?Q?iE26D/kwtJzPrUB5vMtC7vmR+vk9nEYP7vKO9dAXxBK7EkoOcEHpcJvJyFe1?=
 =?us-ascii?Q?Jhq+pfNsfErUfwo46u2g6jyHt+fKKErdnLm3oD2OnnboPjNH8bnvK7TuPlOx?=
 =?us-ascii?Q?9hv889sB/BRmbEG+EwBC43mTPA0WmEewbdw2UxpZAxFa1sKQ/sDJiNXpA+vw?=
 =?us-ascii?Q?fMFVYmfQ9FrH4rOQt1/BM95FssxEnIPpfRogF2aH4655QRnxTsppIGK7LmyF?=
 =?us-ascii?Q?1CbuKNXM80p7qSMOLEWulk9Dv9Yrkeq0uTxpjIMSsbW9LjGl6TTjASQoerPz?=
 =?us-ascii?Q?/bDH+lbe5SK53wL4MckC6/FDVgyRUo10ue7S3C6eOIHULcdP0U6l/rzVetBM?=
 =?us-ascii?Q?mq956vqClMa8yQOwy24y/lvpW+LnCOycmKAJ9kSYjxPSbcQu9+5FOdTUatFH?=
 =?us-ascii?Q?/S01p38yNLHZXOylYfYs6U+GP78ZCS9fZ7nOMzAUX3xokOT1uwCuUXH2NmN1?=
 =?us-ascii?Q?+Lnyepl2AKnWl/oo9USfsa0XYj/84YB3jWE6H+T1nQYtUBG9IeHNcYXN+mtw?=
 =?us-ascii?Q?JNuTWDf44SDK3MdqmgrFhRkrI4dPZrO8YNisPmQUpOxlDfzCXhBGPGX9V+wc?=
 =?us-ascii?Q?07s1vbF9svVK1Gyue2YyDG7hMIuwZj68FVuA1eFsUh/oe1IYqxlx/tEpmXYw?=
 =?us-ascii?Q?NPEyZ4aA7irW8oy0rv34UOO6FFWsnOOvzr56w9u0Gk+hmOqze7VzmtCAr+JF?=
 =?us-ascii?Q?POnToXc/Zg/fbeBXa5OiJz36kBpuddppmpHQesIEhjgzRJG5UkcUeajR32Hj?=
 =?us-ascii?Q?aueWYQ=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff0cb88-1ef0-4db8-2e90-08d9e2a5b616
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 21:32:40.5461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q7IL3mXVmZh4HG14avh+9kYvNPvoP/t7NN5e7aZ56YPkePW5Gy+ky4NrPDh0yQEeA7p0x+gWN9UYckkiYKOWMr0QOwktWNhxGtfsDqW3Q+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2204
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 04:19:12PM +0200, Andy Shevchenko wrote:
> On Wed, Jan 26, 2022 at 3:19 AM Colin Foster
> <colin.foster@in-advantage.com> wrote:
> > On Tue, Jan 25, 2022 at 05:12:45PM +0100, Horatiu Vultur wrote:
> 
> > The only difference is I
> > had copied reg_stride into sgpio_priv instead of making regmap_config
> > file-scope.
> 
> I'm wondering if we may access config via a pointer to regmap.

Ooh... regmap_get_reg_stride() exists. I didn't see that before. That
seems like it is the answer.

I don't know the etiquette here. Ask Horatiu to re-submit, or me send
along a v2, or something else.

> 
> -- 
> With Best Regards,
> Andy Shevchenko

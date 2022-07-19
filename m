Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB9857983D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 13:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbiGSLPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 07:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237442AbiGSLOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 07:14:09 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2049.outbound.protection.outlook.com [40.107.22.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14962FFC8;
        Tue, 19 Jul 2022 04:14:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kF7YCyIxa1dXdFVD5zoAqQOoP+6sGCarwfEb7G94oxigZWQ8XzYnsrQT1kUoQWG/aTQ/TSr/T3jLgC9ZVm3PNit+JYMDQh9HAd+5Y8ZQH7y3qg+NmC66urX+Ko+gf/H+wGY68nXjlBFWs53Gx3h+HeCigjKFSSJFJuwxiqk7/akiMVSYh9kzfqOj4NOR9mjPXwlPBN/CRNvlTIQRidGkHzdUkogNh4Rk/tOpNGuPJ9Z/J/a4iEMpZMNsygkbS5kPnZ/mbiYidUHTt3MtXzwiGdaxXae0baSm5Q7GPcYoPn/PYzinFkJZRp/DeqLP0YdXDBECHyFnrkv//xyvcXTaKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1Fa+uTlCyDDTIqxSQYyqQCpZj/a6D7r1qGwmV+IYHE=;
 b=jY8IFvlM6A6tlACQITGMuaFGZG8aBdZ1WcIaNOKyHmGnvad1yXYXZDg3Sdu+36XnkUCAN0PAYmiOPUMJdQsTd5S/N+dEOqcxHuvBR6oqyI6Uk3pEaKYCu7yLZdUJVa5AaEkJsQB3+SRbQwQtLMVCyXzbShFppkqumxXKd2fn8PCT4UNUjgtwumMVih+eqNX1DBdig9qfVTs+D0qgYBhms9rb/QEdmykRKCuDCs/aMhwUWI7gDUOH9Indq3HYiYtVH9b+mcN4sA0LSFAM8yn4cDVrDc9Gv9P+t2NSb7ixjQLKFx9H+3XFVI3PrHRc7a3w07kKCWITg5mkGroX4vCc3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1Fa+uTlCyDDTIqxSQYyqQCpZj/a6D7r1qGwmV+IYHE=;
 b=dELFJkLre1hJy6GeCfFh2XsGhKSzHmeHljGuV7YGmyp08PWudtECDbcQWc9GTMNLf0Ei+gjdEqUznDYbiM71Erw4nu5jiwW2w00aVtB0C84BZGGEzat21VcAXEGBcedO6jgeEgGFf/1pcg1daKmOXV4WvTl5wkp/LZQgtwAcIIa7JQoriVFbKJk25LC4zej31tFqGLjqma1l5ZTPJhY+0mb6H02+84UkPImB86mTBPcZKzNk0KvSuvCMSoaPoj6srcBcNktABl+N3pU/GlHSDrsY3RhRnFrBGjHApYJLtsplac5RoR5hVah0OTd1UJes6vyTKDGFF2t5ywkEE2XhuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by VE1PR10MB2927.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:112::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15; Tue, 19 Jul
 2022 11:14:02 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6df3:5703:14de:7cc9]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6df3:5703:14de:7cc9%9]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 11:14:02 +0000
Date:   Tue, 19 Jul 2022 13:13:58 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>,
        Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Kuan-Wei Ho <cwho@nuvoton.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 1/3] gpio: nct6116d: add new driver for several
 Nuvoton super io chips
Message-ID: <20220719131358.0dbb4ed3@md1za8fc.ad001.siemens.net>
In-Reply-To: <CAMRc=McSXgCDB=1dX410BYPDw9skd5kRWC1SsoxkvFnrUnVdpA@mail.gmail.com>
References: <20220712143237.13992-1-henning.schild@siemens.com>
        <20220712143237.13992-2-henning.schild@siemens.com>
        <CAMRc=Md7uVpwSweCSfrNJKqhQLYs2sVv9UasL59ZpqJ50fSC5w@mail.gmail.com>
        <20220713123932.753367ec@md1za8fc.ad001.siemens.net>
        <CAMRc=McSXgCDB=1dX410BYPDw9skd5kRWC1SsoxkvFnrUnVdpA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::13) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bfecfdb-7deb-4a26-da1e-08da6977c920
X-MS-TrafficTypeDiagnostic: VE1PR10MB2927:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qg5Uk/epIOtrQuRQSpQ0PYDGnirMUypGUNoM6RaPcTl4JTcqxu+vnffoGoUqPsg9vC5mBamErUuEVTzUokOSdDjfHqhiqtvKD4zv5IFaGHBiQoJR4Y2cQLzR3Btu9SWuvL1Vae4xi0t3nyUEuWzE3bCN8ebuDa79kowuhA+8Tqu198D/ZMwic4dGdUimBEIbV6wr9B5UifEnRyVpnGbystRyUfufo2NBUOwbJdiBPf/g0YfhsHhw516SnjINYjWsaFbXCV+GhrByBCyV5QuGo1kj2CjK8PcHn/VYkzNsk9SnN85qA1/4Gldk/9UnVh7R24DVZZ3zp9kmYOhZSKH0bsZOhEMF/UvzE7mWupIbe6Lh7wRM0s9GGEK2z/MD4xEKQDgoNA1bdBlElI6fdz7xOv0ouSb3lmajmBDco/70bQAUXNQMbGWfrNOb4Mo0eVhQtu1DnnsPQin8z3reyjIoApsQ+j8KwlsWEfF+Ls5OsAdU/An2+orYU5lxdL4ANTeBsUG2m2dsYTs2IPdyRpybUo//9cyz7yQAg+4R3LFjVsUf4OmvY/i3YXyXu9BqCdR3RwQ8EPnpvQsbPxdkcgieKCmhOa5FWenS7kjxPbBUyafXy/QuF6qn6ypMpFwtFqnQEsAX+K2eXNr3ulvmoj6OSMwP0N7lJE4Ehq4Wf+YPImognjK5gGz1wd+NeuGDjDKBiUT61A1Y+EY1jn3Z1dQCR3a/hGP5nGMuFLoa2dtWxjjIHMoF/c91NSYQ1V1Ij+4S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(8676002)(66946007)(66476007)(5660300002)(66556008)(54906003)(4326008)(8936002)(316002)(6916009)(86362001)(2906002)(38100700002)(82960400001)(53546011)(478600001)(186003)(41300700001)(6666004)(6506007)(6486002)(6512007)(9686003)(83380400001)(1076003)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gscpKokgYiD6+727gMeogy/aKxyZTKcu9XeOMFDJ8hOXla+aXDbsfkapVmxF?=
 =?us-ascii?Q?IELHn2Fu82btNrClKkDAdqVBnMUUSTrA09W91mDVsgufdZ1eSQ52rQFuJpo3?=
 =?us-ascii?Q?PNaQfl+JSxe4z+pOXWRHTvOQNNDvq6i3RPaUg7D/VB00SQ2YH1IqkLuP1cpz?=
 =?us-ascii?Q?yrXVBnsGwXSyZ912c4VExKxY0Q6IxqqzwUoLmIsraIkxxi+dI/+zZZuGSphu?=
 =?us-ascii?Q?5ckN+xx+X5MOF2cBJdTZRp1o7f2aFfNbP+L44qzpIfh38u22B5HFMH7AmMdD?=
 =?us-ascii?Q?+v9La56wxJJIYQliZ9CmfezTAuCHZxcxuBMU6yoSWK71B40ALYJQ9BljitkT?=
 =?us-ascii?Q?3OBmD/nkN6uRCzHtbTqAcvoVYrBuF0cNHSoPRtCMAgcgCMZeJdBqLNDsoM4f?=
 =?us-ascii?Q?+ZyQkhemhTnE5wTq5NwJ9GPV4VO6iz3scAPlzl9sb1WKiY5RkBkYGJadb3zD?=
 =?us-ascii?Q?PBPealuMJW6ypoKZYPwX+ysxPxFdVivQUJTVVZGTv9i+S+Pzz3jNbiQY/714?=
 =?us-ascii?Q?iQmOMQlVl2bVBYVU9LDPLFGzNO40wVXGRjB2QVLQ/K07w5TVHD/FSzN7Vwf+?=
 =?us-ascii?Q?WHYiI7yLVpXCgPMx1cqXv9kM1s5Fj84a4Twm1+jEahV8Q8s1IL+9/HE3lfLr?=
 =?us-ascii?Q?ZpyH+HZfYGxRm9bBM+IIkN4a5jUHe/1DHcyBSKc2x0A4u/hop4DRH6Rn/zFA?=
 =?us-ascii?Q?H3Kd314IM5Er3+yJF2Zh14vAj0/cOd6kQxKr5P00mRu08Ygxb2r6KXPApj8i?=
 =?us-ascii?Q?i4DbVlIG/TaTI7XFWnDXobnJFNOm6/LLgWQy9QMtKpcbSh0nJ6/owwn04y0B?=
 =?us-ascii?Q?pC1n2myWnTwysFbT+4UT4ESyugkR8Cbcly+kmCln/A+8pl1GU5eWxp4JY3hx?=
 =?us-ascii?Q?lcLJkWY+h8GElWPJjjZpIB19bmXOg9v8CylTCb6/8118+4nKZw0HM5qPe9cz?=
 =?us-ascii?Q?+Ncmt9V9ENtsKLk5lrSj3oaEwVxqWhHPioO9omWt1O9b5mQ+lcyoeGTUis7Y?=
 =?us-ascii?Q?Y4t0E/Tjs6f7nbFWszoJqOLr6yORNX4kQwCmLvCohTNHNDYrkTBc24vmA2UH?=
 =?us-ascii?Q?AIjZ7TcdrHrSZ0rKZ6pNgSrYHgEzyBM4fTt4jFuNPWdWXLj+sgmgNAjkGBTh?=
 =?us-ascii?Q?NbiBKX4kDt0xfgWT9VDyhPPwDM+gSvAJ4692oD3Hz/oRTeHGVQ7Uo4VTzgny?=
 =?us-ascii?Q?7P54dLtItELTUrHo5Ffnzfg/HRbOE755//63XZpBKiVJ1qwc9Y9Zb9O2ZxRn?=
 =?us-ascii?Q?5otaJKUJ9MHPhdXM6J14qCx+jtsuFXUwJsqSRh7gHJkTZdGyfpcN1r551tr0?=
 =?us-ascii?Q?gzfY68GzqEtmoq/u1TKY2gYwgNZ/GOAMnl+eY2vSducv1Z/3Te7jAY+dyAyt?=
 =?us-ascii?Q?6OYzl3JBm7gaHh+S3vBOhuBGO4XBicKtse/85A9b3NKlQ3Tqy4c04Ljx+MfA?=
 =?us-ascii?Q?flCKH+QpH5e6LzmMGN6Q917l8tZdh3gLere9DzZ206ttWsBodH1EQXhksT0U?=
 =?us-ascii?Q?9cpS7pblYTraJG8fwwzTD9bmVMjRvuhh9+rlDSsONk/wexrLC53IvHM9UXBG?=
 =?us-ascii?Q?Boj5vo3CNO+k3UEChdUg0ioi657Qq+mOebhLyqATcQ0lrlE0zRLZAU+ra/vf?=
 =?us-ascii?Q?hrYW033h9uSlwj/F7PXFf5zRXYbkAl8IbZZWGlwYkQs/98yhmdZ9XbImhAmx?=
 =?us-ascii?Q?hmZExA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bfecfdb-7deb-4a26-da1e-08da6977c920
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 11:14:02.7631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85PfSKtEM3K6v3Q8zCrcmro8fkZXiTmLMVjdt1/+m5LINvxBYxXD8SJXSvQlZGMHuDf5LJaSpUelEy8jzSjj/TIyKHbD/f/JXRgHRqWPtak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB2927
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Tue, 19 Jul 2022 11:39:44 +0200
schrieb Bartosz Golaszewski <brgl@bgdev.pl>:

> On Wed, Jul 13, 2022 at 12:39 PM Henning Schild
> <henning.schild@siemens.com> wrote:
> >  
> 
> [snip]
> 
> > > > +
> > > > +static struct platform_driver nct6116d_gpio_driver = {
> > > > +       .driver = {
> > > > +               .name   = KBUILD_MODNAME,
> > > > +       },
> > > > +       .probe          = nct6116d_gpio_probe,
> > > > +};
> > > > +
> > > > +static int __init nct6116d_gpio_init(void)
> > > > +{
> > > > +       struct nct6116d_sio sio;
> > > > +       int err;
> > > > +
> > > > +       if (nct6116d_find(0x2e, &sio) &&
> > > > +           nct6116d_find(0x4e, &sio))
> > > > +               return -ENODEV;
> > > > +
> > > > +       err = platform_driver_register(&nct6116d_gpio_driver);
> > > > +       if (!err) {
> > > > +               err = nct6116d_gpio_device_add(&sio);
> > > > +               if (err)
> > > > +
> > > > platform_driver_unregister(&nct6116d_gpio_driver);
> > > > +       }
> > > > +
> > > > +       return err;
> > > > +}  
> > >
> > > I'm confused - have we not discussed removing this part?  
> >
> > Ah, i thought the problem was the use of subsys_initcall because the
> > comment was under that line.
> >
> > To he honest i do not know all the details since i really just
> > received that driver.
> >
> > What is happening here is that some init code goes and probes well
> > known ports to discover which chip might be connected there.
> > Looking at hwmon, watchdog and similar gpios ... that is the
> > established pattern for Super IOs.  
> 
> I just thought that you would use the simatic driver you mentioned to
> trigger the creation of the devices upon some event. This is what I
> got from your previous email. But that's fine - if there's a repeating
> pattern of doing it this way, then I won't object. I'm not an expert
> on Super IO kernel drivers.

I am not an expert either, just looked at several similar drivers for
inspiration.

In the next round i will propose an "adding the chip" to an existing
driver. That will greatly reduce the amount of code needed. And we do
not have to copy the pattern, we just reuse the existing one.

> > Not DT or ACPI bindings. Something has to load that module to make
> > it init, where it will go and enumerate/poke around.
> >
> > While i could likely put a platform_device_register_simple("driver",
> > 0x42, "chip42") into the simatic platform, then the driver would be
> > pretty useless when not having ACPI (for there Super IOs in
> > general!). There already are hwmon and watchdog drivers for exactly
> > that chip.
> >
> > watchdog/w83627hf_wdt.c
> > hwmon/nct6775*
> >
> > All are based on someone has to "know" and "modprobe", which will
> > cause "finding"
> >
> > The pattern we have here seems all copied from gpio/gpio-f7188x.c,
> > another super similar driver is gpio/gpio-winbond.c (which is param
> > based and not at all reusable in other drivers).
> >
> > Looking at hwmon or watchdog, Nuvoton/Fintek/Windbond are sometimes
> > called a family. But the driver landscape in the kernel is very
> > spread and a lot of copied around code. I did not even look into
> > tty/serial or whatever other functions these Super I/Os offer.
> >
> > Looking at the way Super IO chips are driven in the kernel, it seems
> > all about writing a driver for each sub-function (uart, hwmon,
> > watchdog ... and gpio). Where even very similar chips gets new
> > drivers instead of making existing drivers more generic.
> >
> > I am just observing this and proposing a "similar copy", which i did
> > not even write myself. At some point it might be better to rewrite
> > all that and make Super I/Os platforms that discover the chip once
> > and then register all the many devices they have. Where ressources
> > are properly reserved and not that really weird "superio_enter" with
> > "request_muxed_region(base, 2, DRVNAME)" which can be found all over
> > the place. But hey that allows a very smooth mix of in-tree and
> > out-of-tree.
> >  
> 
> A note on that: the kernel community explicitly has zero regard for
> out-of-tree code. :)

I know ;). One of the reasons i am here with "my" simatic stuff.

Henning

> Bart
> 
> > When reviewing this driver i suggest to measure it against i.e.
> > f7188 or winbond and maybe others.
> >
> > Say i would manage to make the nct6116d chip supported by f7188,
> > would that be acceptable? I would have the "init pattern" i need
> > without copying it. But i would add a Nuvoton chip to a Fintek
> > driver ... might be the same family ... no clue.
> >
> > Henning
> >  
> > > Bart
> > >  
> > > > +
> > > > +static void __exit nct6116d_gpio_exit(void)
> > > > +{
> > > > +       platform_device_unregister(nct6116d_gpio_pdev);
> > > > +       platform_driver_unregister(&nct6116d_gpio_driver);
> > > > +}
> > > > +module_init(nct6116d_gpio_init);
> > > > +module_exit(nct6116d_gpio_exit);
> > > > +
> > > > +MODULE_DESCRIPTION("GPIO driver for Nuvoton Super-I/O chips
> > > > NCT5104D, NCT6106D, NCT6116D, NCT6122D");
> > > > +MODULE_AUTHOR("Tasanakorn Phaipool <tasanakorn@gmail.com>");
> > > > +MODULE_LICENSE("GPL"); --
> > > > 2.35.1
> > > >  
> >  


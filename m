Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1AA59F405
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 09:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbiHXHNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 03:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234945AbiHXHNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 03:13:13 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60056.outbound.protection.outlook.com [40.107.6.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F5A94117;
        Wed, 24 Aug 2022 00:13:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOHFUILfC7OgUPjChyXlNp3yPXWyOylMex3mZfcGVZ5gdv1CnytBgrpztEiFGc8BBzGH+1ERj8IB9ExjhJ2PKm0Uy3+U1T5iog2PFKsygo4KyOj0Ep7etcKbs2O20hAfU7VCRkJqzL2yUh1S7Hw82x/GNbuGuy3STZbpFtOmjXJhuIrurk4sD69dwM5fYSqcr9y0tJCqc1ZQ51Ejme6qjEsSYuz3AffstMlOIJxR7LrmcF0GLS3Szn4VDg3yWHlfdOHcYEikp2/AynW+iFVPYgO5QQN517iSKz7p6FrqF3kMJFcSkrWmq7xpessY88DpLStuoCyoWe14qPw4CX+S0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cnoipXSDTIZ3/rpNHDIaz/4dcPgjtiyIWI+vN+Fe2k=;
 b=OdDn608IFVhIGJfrcez6hW3H5ZmnkevfrK8qsQHu84Pd5neRnJOMIq+hXfJGH0UApHLM++OA5y77F7fWw5VjXIKuK8R+XV0ErYQ4ccB1kGWStLaLPp5MKDMSU/HBUd1DB+tBE1Crm1Q7AZJe06XhRr2tj74xsjif8r4Jf4zsaSL5qUvpZj3/FSxr6pkSZAUPamLMKz9l4k2hYRZVfpCcp2r+p/fNm63aWQD84c1mGocelkZtGWugLC/HIlgLVtCwQHoKJPgAyh3THVahkEQ/En2DhBXBLujOR90j2j6Z57jt0wgG4WWl5+Dxyn95iFBi1ky2bpESLU4I8Q8E5b3G2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cnoipXSDTIZ3/rpNHDIaz/4dcPgjtiyIWI+vN+Fe2k=;
 b=nQcL5llzqhJs7wf2mq3nr/1R5UmsxUTSC3Hr7pmA29WOrzGt0G9QfxIK0QXeEDSCi/CNv3GiutCIXPCzgrcM29DHt5l9WBoUHruDrPK+YuVkR6Zr5Kz7FwO1/jtNpxI+YSZGlZtnPAyaxBpyYEc71YQ6JtQvat4kPuQ/AC7yGobmGkLAOZTdQkIRsiwTM2n5l3MlpExMSYFp0RKOknvpC2IeEoZnhdUGQ7B1U03Os6ce+xe8Futnu+HUWZortnnPK6UF97LJf3aRpCRrPcKWlTBzWlrp/ZiaQLwvqZpBfUQvJsKIwmB2oSWv2f1PjLDlW1PrrMzllmWWxsyj7R+BkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com (2603:10a6:10:129::23)
 by AM0PR04MB5476.eurprd04.prod.outlook.com (2603:10a6:208:11d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 07:13:09 +0000
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::c1b3:1b0c:46fc:4b2b]) by DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::c1b3:1b0c:46fc:4b2b%3]) with mapi id 15.20.5566.014; Wed, 24 Aug 2022
 07:13:09 +0000
Date:   Wed, 24 Aug 2022 15:13:03 +0800
From:   joeyli <jlee@suse.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] thermal/int340x_thermal: handle data_vault when the
 value is ZERO_SIZE_PTR
Message-ID: <20220824071303.GE5247@linux-l9pv.suse>
References: <20220808132158.24099-1-jlee@suse.com>
 <CAJZ5v0ig8mkNSrwsUhNVVGeBgB9TMmTDZQQmf_tCV4oJ85VPRA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ig8mkNSrwsUhNVVGeBgB9TMmTDZQQmf_tCV4oJ85VPRA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: AM6PR04CA0052.eurprd04.prod.outlook.com
 (2603:10a6:20b:f0::29) To DB8PR04MB7164.eurprd04.prod.outlook.com
 (2603:10a6:10:129::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d5b5cba-e73b-4b7d-abef-08da85a01924
X-MS-TrafficTypeDiagnostic: AM0PR04MB5476:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z7T7b5CosxYEHM50njf1ByGgwbqysdTwB9ONAlTCiFTDO7u2eLuh/x3IdVrPvTFuG09AW42xAw80ku7rJu7bYglgIAcaU0oh+jLDaTQVHfVWEUvK4Z0r/hOHN06BHedcqAVPE1O7q5TtlufDf54UbpbTHwpgkRR5BER4up4ehTRDN+KWw+ODCcqokTfVIkxjFJqKwRb0VLekIKs6SAk+oAcmKCz0aZnAL9llrcevSZVrXc6Hxsz1+0b4nvGaODyUpW5ECr177iToR5oOIo9GuwWnwf35WPaiXuA5L0kLl9sAv2vOfFzZi64RwFnNa7bECy0K2Y09Vr0GB1IKRceUxoG2q8AOBMJoeZhevXnwlNVDX3wgDV6ECQwrYc9YjULrRQbp+jDg9uQo1jdcHXHsN5mgL7WvhuWfd3IL/muT294JhYSiZq2q9Ag+sQpDcWlTQgKxxOdxPrPknglH0xapEBhrZNWYXF3WeN2waBIdBOWexjv/3CfLYT7azSemkL4Fk4mqGjtUSK+DclE1ju6+FIbLuSsFwuV4PKlAegcLK+K8fOH8MWMPQInp1OJTmasbL2h+6rsPnPXEjEH+qGr6yEeCVDWuXFLOsp/sst7MAwzO375EtFle+uTdu6PeNrOXe983j8CWtXOaqnDA0xTzXSkG1sFH235yt5CeXDPL0WUgUWE6wlJvNIz+LbnjKgqOZQubnB3R471/i4UaL6rYWgADMpj/Y8F8Ju/Gclj2y06wF+Uc9XC6UIHuE5mWtsn1KR2slHdRT5GvSZLYGjIRKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7164.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(39860400002)(366004)(136003)(41300700001)(9686003)(6506007)(6666004)(53546011)(6512007)(86362001)(38100700002)(33656002)(36756003)(83380400001)(478600001)(1076003)(186003)(6486002)(54906003)(4326008)(66476007)(66946007)(8676002)(8936002)(6916009)(316002)(5660300002)(66556008)(2906002)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yER+DvSLTXeVVDGj2Ey96QaNLz0vwwQJ9ZQKWIPMnyX5AnjAF4RsO5AcKTt5?=
 =?us-ascii?Q?CLQxPPaLyqea4jjdFpdTsLeVF4FdzDLWpBxS91ZPMZFJWpyfUq1k6GbqqJ38?=
 =?us-ascii?Q?wr5amGkoa6khbCyKYyMlvzmH8sMgqTwFhZbs03TizDKFaQqJupIkyUjn5/uE?=
 =?us-ascii?Q?EgN/pyaKFa57a7aTnETLGN0flF8Qa3OMu2IWP5h1vNXHPjs93XH0ArW6YivK?=
 =?us-ascii?Q?SI6OVMwb9BcH1kJvUooIYFJFOGRyKcMAk5vGHCZxZzyQW8nROL3u3GHaTp20?=
 =?us-ascii?Q?pjm8jzdxaHppRaL7Ih6aWkVF5Hme7UIK/5NES12hAh1jBOx2Tfqalyzy1DKc?=
 =?us-ascii?Q?o1gTMHYCkPy5gxW0pFDHiJUItG5U1anNxBo+4nhMmoqtZpFOZvmXnCWSAndj?=
 =?us-ascii?Q?L0BRF3fRqbEgGi3fgedwCpdGL1U2Q0nOwdsk1TxjElOtdOYirozqdl+FiIF7?=
 =?us-ascii?Q?6ozpVNtW3XSU2ZsCYOVuYzuMyOnH0oGkxFf0HV/5Z8JM7VLVUr2gMbHueV4d?=
 =?us-ascii?Q?UHNySMPJRejuh8X9t6ActoGSFzaGOsKR1TGa/7LvUHbXv+/WT+nDtm4ktvte?=
 =?us-ascii?Q?wCmMoGdzoYBw/DHvG5bq9w4cVj1NF1OyYL60DK/zu5x7SlLexExzHmbGTzv1?=
 =?us-ascii?Q?FPJd+5wZw+86vkQjeZwmMErM3MRYDqUu9i/YlaLRBp4T006VUqFm2pWn0UB8?=
 =?us-ascii?Q?q40xf4dpUyFAMbx0Ir/PNPdSK8fDSibB8d3gvjhUEOj6N6yGc6CO7Qpt+DU2?=
 =?us-ascii?Q?64ER9NgamWaRqDv2VPnzTc6rOv1klj52mPDtn/kfpazN03qZpZDCgKT9Gm78?=
 =?us-ascii?Q?Wju/VVMHjSUf2F6aXRaBFrSe19YCq4KajgrrHCWOtzomiJ/YAQVcfNHwCFRV?=
 =?us-ascii?Q?27tP9UhHrulZ7Ahn5sEzaWQSg99OgBPAOcncaWnNqZsN5yzZSym+1QqXzd7e?=
 =?us-ascii?Q?y2vOiaL1XFMnKJ4LOlxKVBqbTwXIpAQu9EbrTZLME2MnOu/b3FcgdN7CRNho?=
 =?us-ascii?Q?t4FsnnC+Nj9hbLP9PzWEag0ikKr01q4E1miFimN9YlMIThx8OyZlpAGjHGcC?=
 =?us-ascii?Q?bzc7QlcdrVL6us9VTfnTWkNgzlx6uCxIFOGSJ7QcwoLmKqbxtdGinuqb5OLv?=
 =?us-ascii?Q?LF31SbDfu2fdJPQxWrO5eY3FvR78U5DM2VxwY5oXeKASMBkGX11Yj//sDgmE?=
 =?us-ascii?Q?Bstav1JVyisZDgs6mFPVTooW+gWEkJupZIXWzl8ecCreldYhZjSfJRQ93QHK?=
 =?us-ascii?Q?6C6NhfrEWJp6bEd7EgkFgy19qk9hupy3xmOHLlI4UuAt/8UGmXaZfnrfjpnC?=
 =?us-ascii?Q?RQQRUac0qCSQ8lfj/oUOuXVj1BGYgVJhmIPkK0WAOtno5M26zPFvVYGHuMz5?=
 =?us-ascii?Q?rZ6lCmBa1Xi4oyTIV65jcha2V+8yD9Y/64pWPn/Xm/W7YTu7mN8LbsKGypnK?=
 =?us-ascii?Q?A2BENgVgXLnLkVETJaGScYnowfhiA/f0Z6EAqwY3OqpO01qjVU7R3PzlGcHt?=
 =?us-ascii?Q?2dvdxtsIieKJAhj+7cfG6NWBzYcd9djse1ZmcCSmoDniVzWT4Rj3Qvp1XFZ4?=
 =?us-ascii?Q?PuCmA6Xs2zwMQsSXOK+P+BNzBoz1aziIdM4CF2CaZbg68jqdB/KCvDLAuHxu?=
 =?us-ascii?Q?ZoSW9lFLGtOX9/rmqaO6V4OB43Kg0lHMmNYjZHc7hIs3?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d5b5cba-e73b-4b7d-abef-08da85a01924
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7164.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 07:13:09.1003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CLYu6ElbFaqjidFNUSLWZc6FV4pkX2bIfSEsB/QbonDM3/w8Ob7lXB/NC117XyMs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5476
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 07:53:18PM +0200, Rafael J. Wysocki wrote:
> On Mon, Aug 8, 2022 at 3:22 PM Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
> >
> > In some case, the GDDV returns a package with a buffer which has
> > zero length. It causes that kmemdup() returns ZERO_SIZE_PTR (0x10).
> >
> > Then the data_vault_read() got NULL point dereference problem when
> > accessing the 0x10 value in data_vault.
> >
> > [   71.024560] BUG: kernel NULL pointer dereference, address:
> > 0000000000000010
> >
> > This patch uses ZERO_OR_NULL_PTR() for checking ZERO_SIZE_PTR or
> > NULL value in data_vault.
> >
> > Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> 
> Applied as 6.0-rc material, thanks!

Thanks for Rafael's help!

Joey Lee

> 
> > ---
> >  drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> > index 80d4e0676083..365489bf4b8c 100644
> > --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> > +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> > @@ -527,7 +527,7 @@ static void int3400_setup_gddv(struct int3400_thermal_priv *priv)
> >         priv->data_vault = kmemdup(obj->package.elements[0].buffer.pointer,
> >                                    obj->package.elements[0].buffer.length,
> >                                    GFP_KERNEL);
> > -       if (!priv->data_vault)
> > +       if (ZERO_OR_NULL_PTR(priv->data_vault))
> >                 goto out_free;
> >
> >         bin_attr_data_vault.private = priv->data_vault;
> > @@ -597,7 +597,7 @@ static int int3400_thermal_probe(struct platform_device *pdev)
> >                         goto free_imok;
> >         }
> >
> > -       if (priv->data_vault) {
> > +       if (!ZERO_OR_NULL_PTR(priv->data_vault)) {
> >                 result = sysfs_create_group(&pdev->dev.kobj,
> >                                             &data_attribute_group);
> >                 if (result)
> > @@ -615,7 +615,8 @@ static int int3400_thermal_probe(struct platform_device *pdev)
> >  free_sysfs:
> >         cleanup_odvp(priv);
> >         if (priv->data_vault) {
> > -               sysfs_remove_group(&pdev->dev.kobj, &data_attribute_group);
> > +               if (!ZERO_OR_NULL_PTR(priv->data_vault))
> > +                       sysfs_remove_group(&pdev->dev.kobj, &data_attribute_group);
> >                 kfree(priv->data_vault);
> >         }
> >  free_uuid:
> > @@ -647,7 +648,7 @@ static int int3400_thermal_remove(struct platform_device *pdev)
> >         if (!priv->rel_misc_dev_res)
> >                 acpi_thermal_rel_misc_device_remove(priv->adev->handle);
> >
> > -       if (priv->data_vault)
> > +       if (!ZERO_OR_NULL_PTR(priv->data_vault))
> >                 sysfs_remove_group(&pdev->dev.kobj, &data_attribute_group);
> >         sysfs_remove_group(&pdev->dev.kobj, &uuid_attribute_group);
> >         sysfs_remove_group(&pdev->dev.kobj, &imok_attribute_group);
> > --
> > 2.26.2
> >

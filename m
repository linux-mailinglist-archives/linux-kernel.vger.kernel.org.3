Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA3D4B94E7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 01:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiBQAYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 19:24:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiBQAYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 19:24:09 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2129.outbound.protection.outlook.com [40.107.113.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063002A7976;
        Wed, 16 Feb 2022 16:23:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmPM/96cQuzPOrgYFqG0wmFFcfGO10fqmrWbJ2tXhw7v0m4xxGy6pPIfzq4OLpQaf8BQ785DGRe+Ys7MbfytSesepvv36F+DhA68OGQ7WBuambRw5+g2zaVurY2Tsmi4DynDv9S62Yww/QjR+ExOzGl3a787blnN9BBCUkGDU63piG34Nv0auWT0kglY1T9qHYwwGdL2XPx+qcZEoTM2QtH7Vl5Objmk566PNMeGiPV/alsXuOWL9gfQE0hi7dpju7q0HO1qA6BBARYkNKHBcmCU92AVwxRgpGeBHGN/6rHAOU41gZVAvN8Ms+WvfrW+NKcs6ltXiKZ/psWskmIOeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uuTKMhBA/nLxlTUOtipvcXo+8nI9GnGwBSwbJ8dtKBI=;
 b=c8rtck+Dz31el1c6bx4Q07ABuFzc+KCDWmjKxjPWgSymzj7rgDO7uVc2zHAvy7KxV9HnjwBiubUFiz9HVOJaylJZxqOYG5ivyDg2vCRfVLk/n669eOaQb0tiw0LyhA5AZBPbmASxjsFuMs2p3CwJoRP7K4HSD81Psknm6+ExoIJ3uaJ8x/rfWlYeqTSSrGymhqis045U51S2pD0i5Vp340foD+T2KUgYQW9i5x38bwnlJKCkhIT6JbgoJHfgcamdvV+ptfTKPMKZRU2kz+CWJVrBv3K9ZePllLyz+kdsaW/8jR77cqHDFo59iX04YXEevYw/IiyaLWja0TP5B3ja0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuTKMhBA/nLxlTUOtipvcXo+8nI9GnGwBSwbJ8dtKBI=;
 b=cH4o+0ng4Ieq02vj/GfVbSua08SsCr4lVJc/WPY+SlRdzPPKULHj69xAmbL7BV28Pn+12ygOdRZVkWUlgBiMj/2tYtxBO+9/8ykzHGxpxeR27iCedTe02EzlD0u+yc4YO7LFBCqo6zs43mUg+7z06wfJ8y7svbhE/+TSDzc2Kk8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from OS3PR01MB8426.jpnprd01.prod.outlook.com (2603:1096:604:194::10)
 by TYCPR01MB9813.jpnprd01.prod.outlook.com (2603:1096:400:20b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 17 Feb
 2022 00:23:52 +0000
Received: from OS3PR01MB8426.jpnprd01.prod.outlook.com
 ([fe80::cd07:5f39:5e3c:3997]) by OS3PR01MB8426.jpnprd01.prod.outlook.com
 ([fe80::cd07:5f39:5e3c:3997%8]) with mapi id 15.20.4995.016; Thu, 17 Feb 2022
 00:23:52 +0000
Message-ID: <87a6eq49yq.wl-kuninori.morimoto.gx@renesas.com>
From:   Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH 2/2] ASoC: audio_graph_card2: Add support for variable slot widths
In-Reply-To: <20220216171408.265605-3-rf@opensource.cirrus.com>
References: <20220216171408.265605-1-rf@opensource.cirrus.com>
        <20220216171408.265605-3-rf@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 Emacs/26.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date:   Thu, 17 Feb 2022 00:23:52 +0000
X-ClientProxiedBy: TYCPR01CA0075.jpnprd01.prod.outlook.com
 (2603:1096:405:3::15) To OS3PR01MB8426.jpnprd01.prod.outlook.com
 (2603:1096:604:194::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6107b29-9500-477f-2d15-08d9f1abc6ac
X-MS-TrafficTypeDiagnostic: TYCPR01MB9813:EE_
X-Microsoft-Antispam-PRVS: <TYCPR01MB98131B5848B0658557DC11E9D4369@TYCPR01MB9813.jpnprd01.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WB0Di6ns35zLY0fAVNtkl37ozS+twc/QaPpUhpkZBMj6QldJi7HYnvbePNWmgVZW6oHv3k1SQ2MiwcRrGeBERt4S9WRKeRLp/XIeOUYLErc6pX6Gr0I38qAHR2wzHSNyCQUyTFwWAcnB89k9Uue3sFQBLbY4ly/2qHwPUTgOGCQlhK+/6AGWJHWCZne+PoXb8BXwL8Ae5kGq88RnmstRKz2WtvBiMXZbCxhOT2PnsnySDEw1p5rxEEAPlzTFk3a9wrkNl32OGl+aJmj1kMF6uHsWmlwMjlUjXSA9d0d4bT3OfNpH/Q0H6oqkWmnAF6sMaC0lCLsLsVVUHsJ7rJBhXGJ67ZDxn931D5cBQI25gb9tsO5JuGzaKamWeDxSQyC74Gid2wsZSpl2N1ZcXXbXPHHzW8ksXCNl5Ie0baaKOUtKZTwAJ78+xqbv9mH0ShoQSEfPx8f2MlvnLWikyXLahfv7pPi7UewQT83MHpn0IdPpCZLdHLInMG6feAp5NItGT55WPjuYsR1P4GmJwNeAOuChqW7akBHRGaM8tnj6DFMP46gEgPx08O+ThftHxuSpN2HQBgoBrN/uf1ry5bmVXv/EdSfFlThtIz1IPNmwcVN/YUfEkqBzCwv3aSjPIDmZ9r1OEfirIiX2uY91yOLCfWFk52SA/BJl1KonUNeg+KcT2QyJPP55mpUwlIkntYvzGBc8u08Sz8qgNeppx4cZgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB8426.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(186003)(8936002)(5660300002)(2616005)(26005)(36756003)(86362001)(508600001)(6486002)(6506007)(6512007)(8676002)(4326008)(52116002)(6916009)(316002)(54906003)(38350700002)(38100700002)(66556008)(66946007)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vTnng4G2z16ekeS99vuF+R+hUptkFKDvFVxLOPKfVIxNbPqfXnxHs9FnzjlV?=
 =?us-ascii?Q?Vy3cLpbFlQfizq+XBwdcGdsoaGQYMQDNdHgt1y2eDUdid+ME1y+/+jJWU3ca?=
 =?us-ascii?Q?Qtqe7MQWd/1vus22kuCzRCfBPpxJb6Om4rQv5/9FZpfQpc8V1eAZ6DroodXb?=
 =?us-ascii?Q?5csYGOt2dZdC78IhUhmaA++oTN/lYKcGV1s6UPOvXTD2kg0DZ5f+r6DNZfGq?=
 =?us-ascii?Q?TVodj3r5pBZ0AH4YmgxT9kdYeNUxa8kkfOBEqIYGTLSPgcFkGR+T9mGxakBq?=
 =?us-ascii?Q?CwPwqzDUcdpjMyZyvZPe7lcCMu8j4FeUeuby0+oPUyb15f6ExEcg2vMIwiv1?=
 =?us-ascii?Q?TyGlsdA5Yn5B3L623G/Sd24gTBOxURZ1Sc0pqbI3NmhAA6hB6av80/pnTbkJ?=
 =?us-ascii?Q?Lt2Q4ehrbMxpd5Ywt9oxeAOveZH6WgALSTlW/omziJs6RoBb6F7WI9W953eP?=
 =?us-ascii?Q?5VMB5OKzC9nuzGaznthc62M5ZpQrclyY3EO8Pe7gxCQ7txZLjj1LafGkxlxs?=
 =?us-ascii?Q?QAz6XpPS2Dyrtraesas2HZcl2yCDWcrF6iWTpptqYbC3Ecw8dfIANqw/TZxD?=
 =?us-ascii?Q?V7+i0QsZ+5szVCy+gp8AZm0wZJ3/JOxbxriQJo7fNTWPwci6rCnqNX+uiFCe?=
 =?us-ascii?Q?g0TX2n7mhqrJ2qGwlQf9+TdFBxWfLzNl25PPH5qC4sNFEfjYAH28gC2B0qjk?=
 =?us-ascii?Q?Q8af5/hJpxtDOrLWRMCbmi6l2GqiIeO58iiDZa8uzUm0p7jlUJWEwYFSaEQ4?=
 =?us-ascii?Q?FSz5sRxRZoikbul6jdBxeVrrsgGxFivAwMFyr8MLtiTiO6Ok6q2cJhvDxGK6?=
 =?us-ascii?Q?SNl9NvBUhPiVhUjlUn3A3/nSQ/Mjc4JoQSG7+5jAc7L4G+4yg9GinQOxd21O?=
 =?us-ascii?Q?PPQ/lZVENVNRpwDYjNYLWdjs/rDbUw8hMh1iPdFnkOfvu5nfrbEBVPgUNNUb?=
 =?us-ascii?Q?c/ClWb+1dZS8EXqLFmkE1ADbCtDmkv2yXzBUA+5/tb2tiz9H33glpls1IkNK?=
 =?us-ascii?Q?yFZOFNZLGr+oD4qgPzaClr7w4+1dVO1rTclFVKCMxcpeAJQmTJydfCB0FJ8q?=
 =?us-ascii?Q?gQ6LiEQKwGpLPAvbJOp4fBeENjTRmGB+KlXzOvUOM4WNpJZE5fkCF45rJPu8?=
 =?us-ascii?Q?UunjmdL2tfEjFdzuVHs8Ctc8iL5ud5wol5vbYV868sxDBl587caF+QyQRomm?=
 =?us-ascii?Q?k17Wztvr7G0RLlSeacJd0oYTFuTBB/UlLn5uY0qfOmxuAcUQOTpyjpqmBH0c?=
 =?us-ascii?Q?dqOZTd+n/405WlYJ/Yf1VrDi8jXHfAdcgIGN+5iKIWr/UghwxeJlFmShONaM?=
 =?us-ascii?Q?WALqj6dsQhWSDTNpYL8u47SEPjOs+XCn2i5LsOThPnrMbPfwsIeO2IgJqHXs?=
 =?us-ascii?Q?Ofk45z29EhV4thuwjzi2rlq+lfnB1ixyKQZcXRzCN4XIJIBUEomxCLIBQjEK?=
 =?us-ascii?Q?30ZgqYF6FpCV0mcqmGbeUmFgsgXIY9a5kP63qo/9fowHfA5Za2qKUdGG3NR2?=
 =?us-ascii?Q?07ku8y53IQ7S0t4j7X9T22OYhiVTwprvPf2ahhLTy5Tq7oEf6ZMpE4KoaLHV?=
 =?us-ascii?Q?x4EPchz4+gD+UIzbA9OlZvHOlZSvZYlmaoIGLDv2M8IbIhSl+oc3PorfCezO?=
 =?us-ascii?Q?UWbWInCZ0G+fWeP0E+GX3g+Djl8O2JlD+q8WSg2c1jhMqMlGtA9C95k0yFHh?=
 =?us-ascii?Q?6+CjDyqiAWvYX10NM9mGHZnk3Lj2wU/eFsT5JFzTqdDZOY7t/xFL+EnKhVud?=
 =?us-ascii?Q?AvHTefssyw=3D=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6107b29-9500-477f-2d15-08d9f1abc6ac
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8426.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 00:23:52.7478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2MKp638n7K9exJ1Hgo4FJYDJr4WYiRkNCslYHhLt2fjfVjsxy0Wyrw+Br6dCXu0I4S8EkC7JxoaZ+dQT7eM6WWkHMaAZDKY40owLt4ZWltSKyDVj2lo/Lsj97eEuHhIB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9813
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Richard

Thank you for your patch.
One comment from me.

>  struct asoc_simple_dai {
>  	const char *name;
>  	unsigned int sysclk;
> @@ -26,6 +31,9 @@ struct asoc_simple_dai {
>  	unsigned int rx_slot_mask;
>  	struct clk *clk;
>  	bool clk_fixed;
> +	struct asoc_simple_tdm_width_map *tdm_width_map;
> +	int n_tdm_widths;
> +	struct snd_soc_dai *dai;
>  };
(snip)
> +	ret = snd_soc_dai_set_tdm_slot(simple_dai->dai,
> +				       simple_dai->tx_slot_mask,
> +				       simple_dai->rx_slot_mask,
> +				       simple_dai->slots,
> +				       slot_width);
(snip)
> +	for_each_prop_dai_codec(props, i, pdai) {
> +		ret = asoc_simple_set_tdm(pdai, params);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	for_each_prop_dai_cpu(props, i, pdai) {
> +		ret = asoc_simple_set_tdm(pdai, params);
> +		if (ret < 0)
> +			return ret;
> +	}
(snip)
> @@ -386,6 +479,8 @@ static int asoc_simple_init_dai(struct snd_soc_dai *dai,
>  	if (!simple_dai)
>  		return 0;
>  
> +	simple_dai->dai = dai;

Indeed the relationship between asoc_simple_dai and snd_soc_dai are
very mystery, and current utils is using confusable naming.
We want to have some better solution about there.

Having snd_soc_dai pointer inside asoc_simple_dai itself is not bad idea.
But we can get snd_soc_dai pointer without it.

Please check asoc_simple_dai_init().
Not tested, but we can replace the code like this ?

=>	struct snd_soc_dai *dai;

	for_each_prop_dai_codec(props, i, pdai) {
=>		dai = asoc_rtd_to_codec(rtd, i);
		ret = asoc_simple_set_tdm(dai, pdai, params);
		if (ret < 0)
			return ret;
	}


Thank you for your help !!

Best regards
---
Kuninori Morimoto

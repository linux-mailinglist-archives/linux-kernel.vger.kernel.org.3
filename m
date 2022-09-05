Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A44B5AD09F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237510AbiIEKtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236173AbiIEKtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:49:14 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2110.outbound.protection.outlook.com [40.107.244.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1305281F;
        Mon,  5 Sep 2022 03:49:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IsshZMDQmVW3w6kUa+dN4T1D7bcAdI0+/pAfx7GfO1AWuAHmxGa49Yl/EMcCfG7N+tuJF3EgC2j+Ao32NzTqljV65qqrQDBdHLwqrv/tX6oFcH/ubtzLKiwAAmXxW9udfJt+jX4+sRUL7nABc+S5nERc/RELEifLsMzmrYZcFMB0x7yYNRtv/9fRzQLkqFz29TMVC2YazQXm3oBJaHTEh3LFtJZSTwJgt9wqBYs8xY9jdN4yyBZxT0Ze0loF5wLsW/Odcwfvrqhm1ZdFEYLAGS/2c5ePj9ThLDbgOguyC49POKNHbXh+GTXlI6ezvgbq/mxtzOMYjn63SZRGDUtfcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEN6qAFzdComiHtKOF+IGK2fkQqMvp2gFOny938E+UQ=;
 b=b5phhIkyHIlws7P3s2z+vszHJAbar4aOQd8WGybFppQ57TJQBFMK+z7PVEQLXioK8B/JmKPsJo+0iAlhfcrmueQb+WiA4iVuHixv6wrwm/9e6ut5YAUgs6un8NCVYIfMHHfamgiZIjUYBWaXzCbQOzPK2GHPC59A2rKzq+kbq/1ENzg3YQZQD0pTc/vLiChSETiyKJCHEJSNJN9ElN1Wpx1BeR6c6dmP1z5R/DmEAPXQfuON66mXqt4mgRmWzQD/PmuC2ciGQiH1sQfUzuDj3uX5pRwZr++P45e8bIaZcDGoiF8ACXNZomDD3YGgFs741ZJX1PWDn8ccBs+CmK3h9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEN6qAFzdComiHtKOF+IGK2fkQqMvp2gFOny938E+UQ=;
 b=uxIkNOPgXpPo7fmSF3gzvSLZV1E9vYjxapZoqZpDEushXK6QGMCpaKj2PKmYoJ+44qNWh+vn1JMqLXkuN6bXBptSawBHCSgYtjBQIcRy47jqAoZxYVXwr9Fn3floCUkr1ylpIm9RMz3IT+0R20+8Gh0R0T7Tvl1edXAdyEic3t4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4431.namprd13.prod.outlook.com (2603:10b6:5:1bb::21)
 by MW3PR13MB4108.namprd13.prod.outlook.com (2603:10b6:303:5b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Mon, 5 Sep
 2022 10:49:11 +0000
Received: from DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::2944:20ba:ee80:b9c7]) by DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::2944:20ba:ee80:b9c7%3]) with mapi id 15.20.5612.011; Mon, 5 Sep 2022
 10:49:11 +0000
Date:   Mon, 5 Sep 2022 12:49:00 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@corigine.com>
To:     Joe Perches <joe@perches.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, oss-drivers@corigine.com,
        Simon Horman <simon.horman@corigine.com>,
        Louis Peens <louis.peens@corigine.com>
Subject: Re: [PATCH] checkpatch: warn for non-standard fixes tag style
Message-ID: <YxXUHPWtyrt6kNI1@sleipner.dyn.berto.se>
References: <20220829155358.2546732-1-niklas.soderlund@corigine.com>
 <dc45a7021bb765ea34c5b9228454f255764c7bc9.camel@perches.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc45a7021bb765ea34c5b9228454f255764c7bc9.camel@perches.com>
X-ClientProxiedBy: AS9PR07CA0021.eurprd07.prod.outlook.com
 (2603:10a6:20b:46c::26) To DM6PR13MB4431.namprd13.prod.outlook.com
 (2603:10b6:5:1bb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB4431:EE_|MW3PR13MB4108:EE_
X-MS-Office365-Filtering-Correlation-Id: 62f7ab38-7d7c-4fcc-a43b-08da8f2c4426
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7GaEZf7MSMUtvfggLAQrUU3wiQXqHJ0HDVgP/YZx50qIkfYhHT24eOAkW1WvFtO/z+7I++fSCrWWPDnytLA3jIGgoTvY4F3ceZz4TLjLSyLfclxwO1vIkbOZIEmE8zih+s41Shi2sS51/AnDugpL08xZGXYAKzWo9Lru4xJjGlbCWXscDmi14hPlMz+QFTdNsfDMnx2g3toC8lMwBQo9O6BjGH+q2LSpkaMuvMoM8t2RHd1JGothguvN5Y40YktPgaOtt+rT9c/D7GXfqTpTt/Zou74KrkW2zIYxTWyU1V1FPw8KFn7+W40ZRd2CMgmKtf+0FhuAr+4ey4FWkHXb2s40b+hn0v00XGAd4mZAB6MyYqspvdu2n+NVEI5DNNu6MEuWF8IbCszMJPAgOtpNeXcabAJx5GCZS4lPXO7X832+szAQug4Abe3g3+EMTJjkBxMh1WbQchNMRv1P1X/X4gQqmMOjtbo1FnvzTc+DmDgTPWFj91TpvI/WaSJcIkfK/Qkk6J+mY3zErkZfUj1cX+fcXJbCenos31QI2XAFHdlqZeOaoUqNSYuTuNOjK7jWibMPdbSk38YODCUtP7PLxwRYoOy/eOUHK2HjrkdcJbK1KoCNS8r+F4mSoO/IlderDCIW0Ruo+cX0FyYogWpLMXycrhyyyRPpDH9E1cVNvl5ZBIvfuMNbFdxuaYiWGUycfLkDe2Jk7WQpoI/ph8rRfxqsYTEzsNj6D58BOq4vVnOTFVxQwRovOKpaoeCoxt6g
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4431.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(376002)(366004)(39840400004)(38350700002)(6486002)(38100700002)(186003)(9686003)(6512007)(2906002)(5660300002)(478600001)(8936002)(26005)(4326008)(8676002)(6916009)(66476007)(86362001)(66946007)(66556008)(54906003)(6666004)(107886003)(41300700001)(316002)(52116002)(53546011)(83380400001)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?/yQmA7EWAsPD4XX9nLSDKo545KaS5XKCyWLKgP+vo+DLofaUdrUX9CIjjd?=
 =?iso-8859-1?Q?Z0RY+fkpnl1pu2PrRNgLNoQHnH8p+h0w/PSoOK3xfX2kntXMg25Dte1iGX?=
 =?iso-8859-1?Q?QpncVORG9BRg2xlIBeY+qiogOpbZ1yZT0MsFDJVctk3zLnJr6Sgs7Kj1X+?=
 =?iso-8859-1?Q?gbhOdxAJ+Wyexn5zb940ZUJZMJj/2nVcE7VGfaxbHzhVRdwTTytjgQaFHd?=
 =?iso-8859-1?Q?pNkePfNkgtT9nqXKbCt/SVrim6Seu7vjFGfp5Gfeye48xTXN1wtPcC9Ghl?=
 =?iso-8859-1?Q?hwvaV/qeSPsIdoN9XikyN0ONWm5okxc3O7uFwDi4Q2X6xRsspg0+NVyvxa?=
 =?iso-8859-1?Q?vxLaZrOW4C7WL9M7kqHAgEQC1PWv1yxuxeTW8HimYdiedUPVGSLYeEUWAe?=
 =?iso-8859-1?Q?yAyQk0U9hG3OSb+QELhvoAckhdYQexMh22fQ6b+Iu4seW98ERTRNJ+8FMe?=
 =?iso-8859-1?Q?4n/X8cGUqYQNn/M6kEtOC5rnrGd3baAWvE7cDqL0kTPXKlGYYoiZYLXFSX?=
 =?iso-8859-1?Q?HSwhk2JXBR+8wdwe7Ltrodw7wUHsJQJ3diT6RHOgnXMqy5hVy8/etLSWFu?=
 =?iso-8859-1?Q?GoVmMTZd9vijmzaodI6ptM5dQXFHt0xVlkpQIcri1O+24l5Vw+GE+cxcqg?=
 =?iso-8859-1?Q?9fAjB76AZVxAWL5LBHzyfr5RZRMGwvMZRbu4FpvSpkLU8bGSCp2wB1MaXR?=
 =?iso-8859-1?Q?9xLSMGy00FPm+p9YOcB74XWoA448BwJt7kyf7iRssk+ieGwAiPC4ChliQJ?=
 =?iso-8859-1?Q?llbkTUPvFyz1GsZKERmkn/sNplm1rFSR9FrawQ1Q60b0PCXocTIrrCRt/B?=
 =?iso-8859-1?Q?xA9Ci8U8PpdN7z8+TcAYQciNcJII92s6zX+Eei0WzXiOqA3UBIKQ8fODuQ?=
 =?iso-8859-1?Q?LmKwd2ay7fQpZ7ZGtoI+EAwNbb1AUh0KuZhEOwClyo1KbWouojqfOMmrFL?=
 =?iso-8859-1?Q?58gFCQs5fYQh9jBaqTw+Kvmh1jN+jorUnRsGMEaVkpfsz0IRNHN1e9FIfR?=
 =?iso-8859-1?Q?pmM2g64HO25vt10utiWtUTc7L4pb61/QgLBtG0+3XkheSypi+AECCGS2LN?=
 =?iso-8859-1?Q?seAc4sT3rQabFzYO8IjX0zM5Q0SliApErPur4wh4tWhxB9ZG3rplC61ylL?=
 =?iso-8859-1?Q?OCRYCqUpGdPGkSZUebedzD6wz6oP4LNOZ+yCV33p9Xbz0Vy4KB1HBWxiLe?=
 =?iso-8859-1?Q?L61DmQUUbjFYxrdwOaLocClP3VTeTZ+nKuxwHNTlhtpel5Zcfx2+XHEE5D?=
 =?iso-8859-1?Q?ki8oFM6es4Db9Q1KDtlYCjnjeZG30Exo/bpNsE0+ex34WK1DXAmQG1X/Gy?=
 =?iso-8859-1?Q?aCebM0nFxAQ8RoGxVzZ0rQwF1GdHx5KfHbluODaf47c1LJUOXFu5yUoYN7?=
 =?iso-8859-1?Q?KSV/P1XM7KbwSU8aIKgWar3Tq2GfDEu/BanJadVjTBDgPTzMHOQsDtmnbr?=
 =?iso-8859-1?Q?Fdxacn+b+NnSniiCBXcQUFhdT+AeOPvrrFyLG8w4kVIhgJ+DIYWgRJ+ZMu?=
 =?iso-8859-1?Q?9+CvZDIbCxJ2tqd0pgm+ZSbqwTH0lfAy5ldpyvmn2PKsrs70bk6q7Yd+Br?=
 =?iso-8859-1?Q?aCVJs3fII6p8mpKn9MOFx9/iDM1iWS0m+Bqlm4xkPQUMOwalL1QWZ39TuB?=
 =?iso-8859-1?Q?i8lRA6MZVsDFUDNwvy/Pjd7fLTDB0Ffs0vDIX8EsPi7PnRO18tnrkuMw?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR13MB4108
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

Thanks for your feedback.

On 2022-08-29 23:06:43 -0400, Joe Perches wrote:
> > +			if ($line =~ 
> > /(fixes:)\s+([0-9a-f]{5,})\s+($balanced_parens)/i) {
> 
> Maybe use fixes:? so the colon is not required in poorly formed uses

I tried that but I think it brings more problems then it is worth. With 
that change the check would run for each line of the commit message that 
begins with the string 'fixes', not just in the tags section of the 
message. So it would warn for the commit message,

    The work on foo and bar introduced a bug that can be
    fixed by doing baz.

I think it's for this reason other checks for tags include the ':'.

> 
> > +				my $tag = $1;
> > +				$orig_commit = $2;
> > +				$title = $3;
> > +
> > +				$tag_case = 0 if $tag eq "Fixes:";
> > +				$tag_space = 0 if ($line =~ /^fixes: [0-9a-f]{5,} ($balanced_parens)/i);
> 
> fixes:? here too
> 
> Pity there's no simple way to consolidate this git commit test block
> with the existing git id commit block.

I agree.

-- 
Kind Regards,
Niklas Söderlund

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169C04F6297
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbiDFPER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236325AbiDFPDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:03:37 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C601F161E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 04:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1649245664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2uxPVrLHHZ9WOfVeGUImhWvzOynG/YeguSdsEVVGHVA=;
        b=ZZaliYEEGZExhHKt1KDjEmYrlCdSR5HUvBlf21zOOraAxwq03fcu0cuNuJEWoeVAV22Y+Y
        J2sUPvQzEdMfeu/eKCnozdgMJtcNMXyU3Od4eVNqJkjuXbcM/uQfKUH/2W/v4wcdzM5yMG
        +03sif0KhSHjE77i1QNpvCUP7sj6bBg=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2056.outbound.protection.outlook.com [104.47.13.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-20-OyxXb08sPdeFnHDjXRtlVA-1; Wed, 06 Apr 2022 13:47:41 +0200
X-MC-Unique: OyxXb08sPdeFnHDjXRtlVA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pi3EJybS8nE/4dAyZCFtbM4GXspkfN2lUcmKTCmVIXdKT9kvLMbibMky5AlXn5rVfdPfqVRmfXE0M4gcRqGAI3e5mmQ4RVLWY1t5H1GlvYbnj9rBDYOa8Kr7fll4q45vyG+X15A4piVR7WNI25kuZQE2k64Gnv7V8ffh1FCJV7rsrtxYQJKdr5yZZEgieMpz9FAYi1tq2xhw/1sUn7jWAylx069P18bDcwPeOYRUa2uoL8AqUJ1xErNvBxVryMZNfmbn4bUzCLWpvEypD/Y6hUDsQgxDRbKmWBtlDsqXgXyMV+Wt3tIrZQCQIMjIlM0tXmkvkoUuOQzG5REj00D7hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7Bn3I1F3bpIELEBVtKsSF3gh+6M48Pa+GIMYvFnaVQ=;
 b=b/YwBkgL/X00c296dGzzwmGgNLmQ0eFI4Mh5DWgxdMuy5w97HzEvlrWMrs8Ripbj1gyLh3YHDiNRsHyLSVKDN4zQbvvUTrt31tKi5eEbqnwF9lSay5N9gp+zas5QqsGaHFcUsmH8v0fv8EnWQFIBjKUdsvZNxg0wyN24B15mjkyiaQqO4/FUnU4jCpIKdw/ft2wugxrknHmFah0l0H1qXlonzy97U4Ub/UBVHW0Ju22Lm0RY98trAF3Yjjql6XFMLtZTEMayaBSpfQ/MQQgaxhpJE/G6+0zhjSr4zamUTnO8x1gKTUXUQkGKgvU3O4I5V9WySOPWmZnIo9ZKUQ6DUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16) by AS8PR04MB8867.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 11:47:39 +0000
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::8c82:19c5:ce96:491b]) by VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::8c82:19c5:ce96:491b%4]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 11:47:39 +0000
Message-ID: <f90522c4-f7d6-3068-9789-8c6d893f2768@suse.com>
Date:   Wed, 6 Apr 2022 13:47:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] usb: misc: fix improper handling of refcount in
 uss720_probe()
Content-Language: en-US
To:     Hangyu Hua <hbh25y@gmail.com>, gregkh@linuxfoundation.org,
        mudongliangabcd@gmail.com
CC:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220406073349.22203-1-hbh25y@gmail.com>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20220406073349.22203-1-hbh25y@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS8PR07CA0037.eurprd07.prod.outlook.com
 (2603:10a6:20b:459::9) To VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39af00dc-6885-4e64-43cf-08da17c3402a
X-MS-TrafficTypeDiagnostic: AS8PR04MB8867:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB886738984F9247C34428A9F3C7E79@AS8PR04MB8867.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yVtAZaqAoiaN14zScqPfm7StZKxB26Q+CwmKxzGNGv5x35ye/bMLf7N94zC4/XSD+NZWJ+0rwsD+XpBr9ZiHYSioNEyrCBlh0BYd1ZDbG7PcgHOjG/M4wKG3Df/IXpBiLBnA72QKpUnzBexwh978EIZwIpdMi2BEsgaFp4i+4dQ+fiQezW96s2bB9YtzyfGoF8YFqNNNRvjEmJBgWJPWIO85x3aiaQkZE+rTWywjVGoH3aaHOxbXKxH7WK9ANvz1LlcGKMnVu62tqw7eqRpUopVh9LfCSLNzLUWUBKfpKY9ZA+o6VaA1ZA/6MpqMs9GNUEmn8VZP0gGR8WNJX6P0fjhxaYKJ6WTVf2hWgqgdhDnPxCtf35gQ8n12+XJqUteG8CwENyzXCmW+u2HrM9Ll/q+//c1CuOjXd+/PdgS9vAhTtXfZd0/4bReHsEZoIMlD5yBmnbmrrNM81JERpdl7ITydMA1PRFOEl9GS1bh2o4+6o58Azig3ao7lA0FyuRMpS0rBfMPaSfmEVK4zlRR9OsBN1S8SdHW1j84Ou/Hzh42KW68TlX0c0U1Kf+tWm6iJgUj8oaJ3X/iA4gr5nddRkE8IvVXPN8VZSX7fzZoLpmWYVLWT8qLOGDfdl9EXx4qwg7mG0hA3RIh4qg6+c/AJny/bHiZIe/Cm+iIctW0U5m3Ty63wcQyQgS9d2UDaIgrgP3d7FiEqi2sZmkclb1jTNdmLtoBZUcaOK2Q5JgUZA/U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2526.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(66946007)(2906002)(31686004)(86362001)(4744005)(31696002)(5660300002)(53546011)(316002)(186003)(8676002)(2616005)(6506007)(508600001)(6666004)(6486002)(6512007)(36756003)(38100700002)(66476007)(4326008)(66556008)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1JHn47woJJajBNhUXSVDHWUquLJKixMep3xHTUB1GCkZ7IHCVOWpvhxDqW5Z?=
 =?us-ascii?Q?frXztqFy3bTU3Bs13U05J3vuEZQge9orddgjc8AmF8Cus8oZBSMgBcCNKnHN?=
 =?us-ascii?Q?ZUw91ALush7VNxkoCQPN5GHXbKmT6CyexhuNHzHqr0iy4ec2Gq3V68cyxD/E?=
 =?us-ascii?Q?yFbAbz+Jr9RVO//czQVyFpKBYAD1HhfWllQhPh+dm+6zwQbk9s70+kiCDqUl?=
 =?us-ascii?Q?LFADVXoHizwAf1Pvj2asoYGtU/Y2y781eFGjZ8FE3UYGIf3sUN0FaYl/5v6k?=
 =?us-ascii?Q?v53OPgafeFO+6F1gcrsLIphQseLUs8xtzxC0ycg4mbt9JEGbUGWAD/vqrH8M?=
 =?us-ascii?Q?vIu3jOlBOsl7uAb2uZPcixanrI1LIY94H8gnDsga7C/fM+8DhD4EmHfpErLM?=
 =?us-ascii?Q?sBHyhAkfM62oA3miuiA6VXjxhfF7j2nhGiod9IF0Emw0Mqrs9VfZsMBrB9f5?=
 =?us-ascii?Q?GlvtULx8i4yjIUhFcO1UsHohdeX/wfO66dC21gMEnTROlz/qGnfGGyJTB7qY?=
 =?us-ascii?Q?c+8A9a84Xp2a/hrKhESymsuTAVeefWnGnT4622jzeeNEzer50tdcoB2E9OXE?=
 =?us-ascii?Q?V0I49P/9DyrfevW/uyS4krO9y399ruOM2jDj17KMVcIdiZULeuO2qLnzKcns?=
 =?us-ascii?Q?s3dtZXPG0n7BpijK3SJl+Blpc/4VFHzvTebmNHHYwtw2Vbk6k1VWgvl79rgT?=
 =?us-ascii?Q?8yW9jJEMakP3CrZHoZV4asTIKwIxosTLZ6bi1DKA3C/YpNMxsK/S9LFtKgMq?=
 =?us-ascii?Q?R5zaw+So+xP48ED93UmLgLg6sVm2Tp0yiAN/Y6FfABrUmdoXh1V10HCs8aE+?=
 =?us-ascii?Q?OKHoFc0yGYq4p+rViW4me66XbhilAG6kkqN1CfutrRoU2rbn/Em5JtdKz1Ae?=
 =?us-ascii?Q?Zba6JQlFKRb3+VwKu2s6gGAND9IGKaM307S7x0uqltjA2TqPPz5vRv3GEONv?=
 =?us-ascii?Q?wV61V8HCTMxXfGSRUlk6jcNm9C80njiFC07i4tLEFQskZoX/UKub18y3LrtO?=
 =?us-ascii?Q?9t/m/F755DcjlCfvoLbwR39pNwY//n6J05QfqMF0Zkay1iwqCXMNaKLg3Xpg?=
 =?us-ascii?Q?rXWNrbQnI1sUn60GHV5OW+cDlGj0v2m4cgefmtE4W9JpoVf4Ui1fJoj6fVU7?=
 =?us-ascii?Q?L9Gaoa9+VWO5Zrat6Y3Bce8P/f8AOYyNLrqNUqE7GbvKF46f7Z6Da00qLOub?=
 =?us-ascii?Q?2cCdwJsI7i/cuEFWkm6F0S/GcIOPKBH7mHgsp2DfcOoWISGOND5oK1CE/YcQ?=
 =?us-ascii?Q?BHWKxIM+dJQOHMKuOnH+FMuZHzodFPKq+fpw0tYCfqjw9RRTZYwoSMnftuUx?=
 =?us-ascii?Q?k9HR3/ISZq1GYgWjh8HSJcNmuYimIZBzA5ex2XOXZqvbyX6uRE2PZRbbHZEg?=
 =?us-ascii?Q?Lg5j0dK/jPV5lGNH6x/7dQGg48A4Bb725BDNJm4Wy6qcvt7PskRqIfrlAtl9?=
 =?us-ascii?Q?oGJwVIZG0B8xlU1NB/pJG/5f9BafyUbNRBa2+4GgmPz44FyVeLlMpou3e1b2?=
 =?us-ascii?Q?1+S+TJLPJD36bkqPqR7TmffEWAWKJ77di8cFCm0r2U143v4upeTHamX6otzz?=
 =?us-ascii?Q?d6CX2wn73OpjO65fxfxhfK4LEp2wizUiZ2c5P4HjxKVs66X4V9LId9eVp9Cb?=
 =?us-ascii?Q?lXAh6SScKFms+0z6uQhcRLI91w78N0DQ91eyybPeWw3b2fALTzw+Gei1893P?=
 =?us-ascii?Q?qGXP5QcyLXeYPSC/CkjJs3hOoYNLrR3iNsvEjyyh+K8vh8xE+E78uc3Y8km8?=
 =?us-ascii?Q?KCYAJQT4/tgNjwleqh+F/GlnzU6/7cqkqRxbUABgpQ+1tyvYZ4A7vf5+0phw?=
X-MS-Exchange-AntiSpam-MessageData-1: dFUrfJg5D7tr3w==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39af00dc-6885-4e64-43cf-08da17c3402a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2526.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 11:47:39.0638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FPEGpi51lkG2T8NGjuRGaH2aF3NqgeawanbdyLCBtGWJfmUNJQP5IvVZx6G2uhigiYS4r6S0mn/4dUtCt1n7Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8867
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06.04.22 09:33, Hangyu Hua wrote:
> usb_put_dev shouldn't be called when uss720_probe succeeds because of
> priv->usbdev. At the same time, priv->usbdev shouldn't be set to NULL
> before destroy_priv in uss720_disconnect because usb_put_dev is in
> destroy_priv.

Hi,

I am sorry, but that's a clear NACK.
> @@ -754,13 +753,13 @@ static void uss720_disconnect(struct usb_interface =
*intf)
>  	usb_set_intfdata(intf, NULL);
>  	if (pp) {
>  		priv =3D pp->private_data;
> -		priv->usbdev =3D NULL;
>  		priv->pp =3D NULL;
>  		dev_dbg(&intf->dev, "parport_remove_port\n");
>  		parport_remove_port(pp);
>  		parport_put_port(pp);
>  		kill_all_async_requests_priv(priv);
>  		kref_put(&priv->ref_count, destroy_priv);
> +		priv->usbdev =3D NULL;

That is a clear use after free The patch is no good in this state..

=C2=A0=C2=A0=C2=A0 HTH
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Oliver


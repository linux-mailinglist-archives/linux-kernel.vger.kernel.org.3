Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291A44B946E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 00:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237753AbiBPXVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 18:21:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbiBPXVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 18:21:30 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC26202045;
        Wed, 16 Feb 2022 15:21:16 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9335A784;
        Wed, 16 Feb 2022 23:21:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9335A784
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1645053676; bh=b0+DvnxGnMvJpzxNnmXm+T3EhT8/88ImKezYrOtOKMc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=R5eaFzEIpEDnwVQ0IAgyao0R8EIQR3Z/+s9DNhHvX1czyzFQgNxtN3PmCmtCcMDDx
         zQdfsqr/GL9d3SdO6mv6S3wV4epliDll5HB8Y5JkZQmFVDwkeoNl6yoszj+5mMNbtV
         CEcpeAZH/54HkWctYpWQusPs5jNz1Ej5g6Dj+ln/2HHsoyNNJmozMWWn2nSH5K7oZd
         xzTlj+owxIo7B/xobwS/G5nb5XXSOiFLUsg/IQvsS+TXAEW9WbUSD+7mSiCl7OYpAm
         XdF/HE67tku2aofIAf1BWnn/upJDFS3es8BCAjaF+PhW31j7JRXKa/0HdzeCQ5GuFc
         LtaBgRuUsNdMA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Tomasz =?utf-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>
Cc:     Tomasz =?utf-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/15] scripts: kernel-doc: Relink argument parsing
 error handling to pod2usage
In-Reply-To: <20220104015946.529524-4-tomasz.warniello@gmail.com>
References: <20220104015946.529524-1-tomasz.warniello@gmail.com>
 <20220104015946.529524-4-tomasz.warniello@gmail.com>
Date:   Wed, 16 Feb 2022 16:21:16 -0700
Message-ID: <87o8362yab.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Warnie=C5=82=C5=82o <tomasz.warniello@gmail.com> writes:

> The former usage function is substituted, although not as the -h and -help
> parameter handler yet.
>
> * Transform documentation into POD (3/15)
> See step 1 for the series details.

Again, this doesn't belong here; I'll not mention it for the following
patches.=20

> Signed-off-by: Tomasz Warnie=C5=82=C5=82o <tomasz.warniello@gmail.com>
> ---
>  scripts/kernel-doc | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index c8fbf1d3d5aa..c37fd36860f3 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -16,6 +16,8 @@ use strict;
>  ## This software falls under the GNU General Public License.     ##
>  ## Please read the COPYING file for more information             ##
>=20=20
> +use Pod::Usage qw/pod2usage/;
> +
>  =3Dhead1 NAME
>=20=20
>  kernel-doc - Print formatted kernel documentation to stdout
> @@ -298,7 +300,13 @@ my $blankline_rst =3D "\n";
>=20=20
>  # read arguments
>  if ($#ARGV =3D=3D -1) {
> -    usage();
> +	pod2usage(
> +		-message =3D> "No arguments!\n",
> +		-exitval =3D> 1,
> +		-verbose =3D> 99,
> +		-sections =3D> 'SYNOPSIS',
> +		-output =3D> \*STDERR,
> +	);
>  }
>=20=20
>  my $kernelversion;
> @@ -518,8 +526,14 @@ while ($ARGV[0] =3D~ m/^--?(.*)/) {
>  	    die "Sphinx version should either major.minor or major.minor.patch =
format\n";
>  	}
>      } else {
> -	# Unknown argument
> -        usage();
> +			# Unknown argument
> +		pod2usage(
> +			-message =3D> "Argument unknown!\n",
> +			-exitval =3D> 1,
> +			-verbose =3D> 99,
> +			-sections =3D> 'SYNOPSIS',
> +			-output =3D> \*STDERR,
> +		);

So you were asked before to retain the existing style, including
indentations.

Thanks,

jon

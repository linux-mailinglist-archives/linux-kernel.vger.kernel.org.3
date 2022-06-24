Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA39355A197
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 21:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiFXTJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 15:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiFXTJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 15:09:27 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66B336E2E;
        Fri, 24 Jun 2022 12:09:26 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 73F2031A;
        Fri, 24 Jun 2022 19:09:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 73F2031A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1656097766; bh=RGewBMLVE0KQ/bTKs7DpXZSxrXMAmWieLsFDh9gfy60=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fiSxHoNx/VlLxp0nkv+31DT6YfqlKxFxYuoPx5NMye5FgWBcEDazGICrPj90OcbBi
         OmgXZ0Yq6mjWgp3RY2/RdP8COvyj09V7uMONWG31Rw34/sEJGHF4hU93SwuFW1nHQx
         HeQOwk9kjNBv1AmtuA+YKf5MfYx91YwZtmJ17KIiixCZWN87eqEuC7ANndlg466eIk
         esYlbf52ZGrg6Trc78ncU3/72QnoNTXgFShOVIvwxFwaWnsk/WxrJq7Vy2w6iEdGly
         dA1nxFSreSd6gzUxNwq/t4QAq9Wgnp0aj2naqhycHSxDYFxcKZYTzzSQ9juMUy4kD0
         hQznrow7VLG3g==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Stephen Kitt <steve@sk2.org>, linux-kernel@vger.kernel.org
Cc:     Stephen Kitt <steve@sk2.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: admin-guide/sysctl: escape % symbols
In-Reply-To: <20220624110230.595740-1-steve@sk2.org>
References: <20220624110230.595740-1-steve@sk2.org>
Date:   Fri, 24 Jun 2022 13:09:25 -0600
Message-ID: <871qvd6fq2.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Kitt <steve@sk2.org> writes:

> % symbols need to be escaped to render correctly here, do so.
>
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---
>  Documentation/admin-guide/sysctl/kernel.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index ddccd1077462..079a51ed88a9 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -38,8 +38,8 @@ acct
>  
>  If BSD-style process accounting is enabled these values control
>  its behaviour. If free space on filesystem where the log lives
> -goes below ``lowwater``% accounting suspends. If free space gets
> -above ``highwater``% accounting resumes. ``frequency`` determines
> +goes below ``lowwater``\% accounting suspends. If free space gets
> +above ``highwater``\% accounting resumes. ``frequency`` determines
>  how often do we check the amount of free space (value is in
>  seconds). Default:

Interesting...I had to go digging into why this is, because "%" isn't
really special for RST.  The real problem is that ``literal`` markup
needs to have word separators around it, and the recommended solution is
to use "\ " instead.

So I'll apply this, but tweak the changelog and add the extra spaces.

Thanks,

jon

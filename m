Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A6B51A129
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 15:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350756AbiEDNpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 09:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350741AbiEDNo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 09:44:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935F524F12
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 06:41:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3992F619D0
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 13:41:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB540C385A8;
        Wed,  4 May 2022 13:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651671681;
        bh=jw7zUbrlhazFO3+mVKiDdtJjleKdC7a/rqXJoqbRRpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T8Df1X+FRxZQW16keZRhs1DfbXX/QajNJBXsAq3JC/F7pNyFVVguLvW04dqGEzxll
         2m7zRulLXO6gmNN1bHwYxpD3NDmymFNRYOtIoQLc7JpdG3dCYVBuk0Xlo0rZg+GEP5
         QMmCEum9+S/p8BRdu3eMqaHWtM+YtGqmqsZ5YcDypl9CAyAAhifzZiJP1jLhwn/JR6
         EwrS3jmd0SEm+58pbHr/Sz7NQKdozpO98NY9iueHVqBm8z9CuU3K2UQuTxgdt2fIfS
         DW6XwiOG4fh1W4bzs4cjyO/xNwrHHsysKbdDCqOVWNJEa/hkNpaO+H1C0nWSIfIBOa
         DxfwWRpGPBy6Q==
Date:   Wed, 4 May 2022 14:41:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     mark.rutland@arm.com, will@kernel.org, maz@kernel.org,
        qperret@google.com, tabba@google.com, surenb@google.com,
        kernel-team@android.com, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Andrew Jones <drjones@redhat.com>,
        Keir Fraser <keirf@google.com>, Marco Elver <elver@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] KVM: arm64: Factor out common stack unwinding
 logic
Message-ID: <YnKCeci08OY7uk0N@sirena.org.uk>
References: <20220502191222.4192768-1-kaleshsingh@google.com>
 <20220502191222.4192768-2-kaleshsingh@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JeDypAEY5KrfMCxE"
Content-Disposition: inline
In-Reply-To: <20220502191222.4192768-2-kaleshsingh@google.com>
X-Cookie: Mother is the invention of necessity.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JeDypAEY5KrfMCxE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 02, 2022 at 12:12:01PM -0700, Kalesh Singh wrote:
> Factor out the stack unwinding logic common to both the host kernel and
> the nVHE hypersivor into __unwind_next(). This allows for reuse in the
> nVHE hypervisor stack unwinding (later in this series).

Reviewed-by: Mark Brown <broonie@kernel.org>

--JeDypAEY5KrfMCxE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJygngACgkQJNaLcl1U
h9Bnigf/SrnKbQKJZQjo1OskfncvQ0A42sToBqNL5kFNTNT7vFVbZwv1bx3TllPk
HvffoX8n/CrQ3ly+MQjLaS2sLBmjn/pHC735ihAUGl8O/UtYP3T0A90WK28Hw+vE
yEPVzhzm7fKGIK97QdbVqaKsDZmFifbEFfL51BQpbCZessqwuQq/ZnmvNKg9je0S
C6TMpY4yEn9mVEWSS5LBcBYVOlt8O9Kz2gNUA5irxdVcnzTG1iwYmiAO6F3Yv1to
OxU+Hnlu+v1lG7ZV4V6+ngrr+RCeSFKEDCGCAlDHnvamwWW7flrIwqAXzP1DzTx+
1AKWv2X394fnYOpTbckzPzzUV6G7mQ==
=/zNs
-----END PGP SIGNATURE-----

--JeDypAEY5KrfMCxE--

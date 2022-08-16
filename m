Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78BC5961D4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 20:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbiHPSDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 14:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236680AbiHPSDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 14:03:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA5F6580E
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 11:03:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DCE561330
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 18:03:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA73C433D6;
        Tue, 16 Aug 2022 18:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660673008;
        bh=G3oMU9H2bOD8Or2niXHgSPfeXd+eJLRmhjE1HQYY2Yo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TrfTG8CM2Eahz1Oe5xci61NtpAGdT3pJyr6A+2YaLwMxW48IRs79p3iqOM/qzP7Kw
         w94vBpCgUjtv55C2rFg4+0zoeQVDWe9k2AY8WpyB6FUzSVq43GdYRdCPFi33Zfc+nU
         YhmOZHiD5ANdLIdNb04DQX0d3pSsWT92PDEutYLI7xMyvgqi1is+L3X/m89bx4nUoj
         +0tQ0dvaOC7E0eUz8BmLMVhZzCyT7XZ+C9IR//GQBKm4sDM3FXbkx5QEJwxP/e1cul
         n/lwd7DQLABp8W/N+DA9fi4HwGpiagcxU/6jYyLJ+xf8S5BWr30jUd52DBSJk2AQb/
         Pry17doAhQAUg==
Date:   Tue, 16 Aug 2022 19:03:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        peter.hilber@opensynergy.com, nicola.mazzucato@arm.com,
        tarek.el-sherbiny@arm.com
Subject: Re: [RFC PATCH 5/6] firmware: arm_scmi: Add raw transmission support
Message-ID: <Yvvb6Y+lzuABT1fy@sirena.org.uk>
References: <20220816072450.3120959-1-cristian.marussi@arm.com>
 <20220816072450.3120959-6-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oZ5z/uvlaRT/pQfx"
Content-Disposition: inline
In-Reply-To: <20220816072450.3120959-6-cristian.marussi@arm.com>
X-Cookie: laser, n.:
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oZ5z/uvlaRT/pQfx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 16, 2022 at 08:24:49AM +0100, Cristian Marussi wrote:
> Add SCMI Raw mode support which exposes a userspace interface rooted under
> /sys/kernel/debug/scmi_raw.

> Raw mode can be enabled/disabled at runtime via ./scmi_raw/enable.
> Once enabled, all the regular SCMI drivers activity is inhibited and a
> userspace application can then inject and read back bare SCMI messages
> writing and reading to/from ./scmi_raw/message* entries.

Is there a strong reason to have the runtime enable/disable?  Given that
this is going to be used in special kernel builds rather than something
people have as standard it feels like the transition to/from raw mode is
opening up a set of extra use cases that wouldn't normally come up for
the SCMI drivers (especially if the testing ends up leaving the firmware
in a weird state).

--oZ5z/uvlaRT/pQfx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmL72+kACgkQJNaLcl1U
h9AnIAf/UnFBTCcR2aSpToxnm1QOwTQhIIgWQ/EVMyflE/XcKEvUfHOiqtGmzGsf
rl8P2gEYq1XtBvgtCLLPL9UVypr9TLgG01TRf8VimCR/V6rV/jQd/XCHcvYKDwFH
6ld6Yh6QWXuqj/Qs53g7KTiv3To3G6trbMhkCKZ4ooqGXvWqtWs5l+c/2E67Zc2i
+51W8axpcx9CWuF6nqqO1MKlcoIL3PpPD21I8qlRvp8hueKgVtE9DLE3RaJlFvFA
eslDuT011nyrlBkbwH5PKU3B85NXaixpSU4vBkFS3nOcCn+ZviUBGuc5LV5NxGYI
x/mnqNwXBOL1WYv40GCf2zXbLGGa/g==
=K2vg
-----END PGP SIGNATURE-----

--oZ5z/uvlaRT/pQfx--

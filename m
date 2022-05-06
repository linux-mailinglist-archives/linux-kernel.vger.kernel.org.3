Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAAA51D5EA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 12:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391074AbiEFKsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 06:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391076AbiEFKsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 06:48:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE3367D04
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 03:45:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E609D21A8A;
        Fri,  6 May 2022 10:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651833905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JBwOt1RF8EsTJcYBYl+0GNWlwHFwIOlw9+R5hnEyELE=;
        b=eSPSjotpfRcOWk0jZW9qANamWjseFdMATaSNtU3/M/YzCU8f/1EGO32s1kLoMfwMEd7sJs
        SfYKP9rKZm6yNSUYyqwgRjwLu3n1ihRt7/hCRH2HPhyapKVhq3NdcJKuPYBCEq0VweOoCY
        TrDMoyMTrCpnqtdUFKxFUtZaTLeapIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651833905;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JBwOt1RF8EsTJcYBYl+0GNWlwHFwIOlw9+R5hnEyELE=;
        b=8mDMrK8Nueh1reSSRQTYjwoLgqHT8TZPnSaw/2hxkXI2CzfTBgdzkbsenoKH3ZLkLpJoGp
        ui8lVBkXF0GPJfAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9B56813AA2;
        Fri,  6 May 2022 10:45:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iWjCIzH8dGImAwAAMHmgww
        (envelope-from <jroedel@suse.de>); Fri, 06 May 2022 10:45:05 +0000
Date:   Fri, 6 May 2022 12:45:04 +0200
From:   =?iso-8859-1?Q?J=F6rg_R=F6del?= <jroedel@suse.de>
To:     Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
        Xinhui.Pan@amd.com
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [BUG] Warning and NULL-ptr dereference in amdgpu driver with 5.18
Message-ID: <YnT8MAjb/jW4ENVS@suse.de>
References: <YnTAc96Uv0CXcGhD@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YnTAc96Uv0CXcGhD@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 08:30:13AM +0200, Jörg Rödel wrote:
> [81829.087101] ------------[ cut here ]------------
> [81829.087105] WARNING: CPU: 4 PID: 644 at drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dce110/dce110_clk_mgr.c:140 dce110_fill_display_configs+0x4a/0x150 [amdgpu]

Same just happened with a kernel built from latest upstream, based on
commit fe27d189e3f42e31d3c8223d5daed7285e334c5e. So it's at least not
the iommu changes causing it :)

Please let me know if I can be of any help debugging this further.

Thanks,

	Joerg

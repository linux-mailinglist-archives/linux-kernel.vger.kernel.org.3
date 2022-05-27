Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8382535C8E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 11:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350569AbiE0JIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 05:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350678AbiE0JFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 05:05:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DA6101EA
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 02:00:41 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1A65C1F959;
        Fri, 27 May 2022 09:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653642040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=EViVKY2FVjnvr6yQp2UwmTPz4Dn5MavSzLh0EqzU3t4=;
        b=HeAdzj2ys/dmuUdAEEB2Zva3TnYtnc60Dc7/s5ED/sbWgI5ggMBd+TANkDN5/fFP37cv1z
        qJpOPMk7nzvJTyB5HxadZR0sfzcSdjjwVnAx+himI2qZ3bmwiwW1dkTSg0jK5GxCrLtBJK
        tjUrXmXwPYK3B/GADpGTC1mkPlZ7Tg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653642040;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=EViVKY2FVjnvr6yQp2UwmTPz4Dn5MavSzLh0EqzU3t4=;
        b=i26fGCtafYK06ajHsztnc3UvHxEEIPb4VP/hlZ6L67SPGnBvCntWF13m45/RtkZdLuoI5I
        Ayanzqt6T7uT+1Bw==
Received: from lion.mk-sys.cz (unknown [10.100.200.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0D6CF2C142;
        Fri, 27 May 2022 09:00:40 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
        id DA6DB608E0; Fri, 27 May 2022 11:00:39 +0200 (CEST)
Date:   Fri, 27 May 2022 11:00:39 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     amd-gfx@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org
Subject: amdgpu errors (VM fault / GPU fault detected) with 5.19 merge window
 snapshots
Message-ID: <20220527090039.pdrazo5e6mwgo3d3@lion.mk-sys.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gtypyrxkzavvymbx"
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gtypyrxkzavvymbx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

while testing 5.19 merge window snapshots (commits babf0bb978e3 and
7e284070abe5), I keep getting errors like below. I have not seen them
with 5.18 final or older.

------------------------------------------------------------------------
[  247.150333] gmc_v8_0_process_interrupt: 46 callbacks suppressed
[  247.150336] amdgpu 0000:0c:00.0: amdgpu: GPU fault detected: 147 0x00020802 for process firefox pid 6101 thread firefox:cs0 pid 6116
[  247.150339] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00107800
[  247.150340] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0D008002
[  247.150341] amdgpu 0000:0c:00.0: amdgpu: VM fault (0x02, vmid 6, pasid 32780) at page 1079296, write from 'TC2' (0x54433200) (8)
[  248.866434] amdgpu 0000:0c:00.0: amdgpu: GPU fault detected: 147 0x00120802 for process firefox pid 6101 thread firefox:cs0 pid 6116
[  248.866438] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00138802
[  248.866439] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0D008002
[  248.866440] amdgpu 0000:0c:00.0: amdgpu: VM fault (0x02, vmid 6, pasid 32780) at page 1280002, write from 'TC2' (0x54433200) (8)
[  248.866775] amdgpu 0000:0c:00.0: amdgpu: GPU fault detected: 147 0x000a0802 for process firefox pid 6101 thread firefox:cs0 pid 6116
[  248.866776] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00138C01
[  248.866777] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0D008002
[  248.866777] amdgpu 0000:0c:00.0: amdgpu: VM fault (0x02, vmid 6, pasid 32780) at page 1281025, write from 'TC2' (0x54433200) (8)
[  248.866884] amdgpu 0000:0c:00.0: amdgpu: GPU fault detected: 147 0x00020802 for process firefox pid 6101 thread firefox:cs0 pid 6116
[  248.866885] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00139400
[  248.866885] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0D008002
[  248.866886] amdgpu 0000:0c:00.0: amdgpu: VM fault (0x02, vmid 6, pasid 32780) at page 1283072, write from 'TC2' (0x54433200) (8)
[  248.866939] amdgpu 0000:0c:00.0: amdgpu: GPU fault detected: 147 0x00020802 for process firefox pid 6101 thread firefox:cs0 pid 6116
[  248.866940] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00139800
[  248.866940] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0D008002
[  248.866941] amdgpu 0000:0c:00.0: amdgpu: VM fault (0x02, vmid 6, pasid 32780) at page 1284096, write from 'TC2' (0x54433200) (8)
[  248.867000] amdgpu 0000:0c:00.0: amdgpu: GPU fault detected: 147 0x00020802 for process firefox pid 6101 thread firefox:cs0 pid 6116
[  248.867001] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00139C00
[  248.867001] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0D008002
[  248.867002] amdgpu 0000:0c:00.0: amdgpu: VM fault (0x02, vmid 6, pasid 32780) at page 1285120, write from 'TC2' (0x54433200) (8)
[  248.879700] amdgpu 0000:0c:00.0: amdgpu: GPU fault detected: 147 0x00020802 for process firefox pid 6101 thread firefox:cs0 pid 6116
[  248.879704] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x0013D600
[  248.879705] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x03008002
[  248.879706] amdgpu 0000:0c:00.0: amdgpu: VM fault (0x02, vmid 1, pasid 32780) at page 1299968, write from 'TC2' (0x54433200) (8)
[  248.883086] amdgpu 0000:0c:00.0: amdgpu: GPU fault detected: 147 0x000a0802 for process firefox pid 6101 thread firefox:cs0 pid 6116
[  248.883088] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x0013EE01
[  248.883088] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x03008002
[  248.883089] amdgpu 0000:0c:00.0: amdgpu: VM fault (0x02, vmid 1, pasid 32780) at page 1306113, write from 'TC2' (0x54433200) (8)
[  249.191811] amdgpu 0000:0c:00.0: amdgpu: GPU fault detected: 147 0x00020802 for process firefox pid 6101 thread firefox:cs0 pid 6116
[  249.191815] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00142C00
[  249.191816] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0D008002
[  249.191817] amdgpu 0000:0c:00.0: amdgpu: VM fault (0x02, vmid 6, pasid 32780) at page 1321984, write from 'TC2' (0x54433200) (8)
[  249.193491] amdgpu 0000:0c:00.0: amdgpu: GPU fault detected: 147 0x00085202 for process firefox pid 6101 thread firefox:cs0 pid 6116
[  249.193493] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00142C01
[  249.193493] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0C052002
[  249.193494] amdgpu 0000:0c:00.0: amdgpu: VM fault (0x02, vmid 6, pasid 32780) at page 1321985, read from 'CBC1' (0x43424331) (82)
[  249.925909] amdgpu 0000:0c:00.0: amdgpu: IH ring buffer overflow (0x000844C0, 0x00004A00, 0x000044D0)
[  250.434986] [drm] Fence fallback timer expired on ring sdma0
[  466.621568] gmc_v8_0_process_interrupt: 122 callbacks suppressed
[  466.621573] amdgpu 0000:0c:00.0: amdgpu: GPU fault detected: 147 0x000a0802 for process firefox pid 6101 thread firefox:cs0 pid 6116
[  466.621575] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00161401
[  466.621575] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0B008002
[  466.621576] amdgpu 0000:0c:00.0: amdgpu: VM fault (0x02, vmid 5, pasid 32780) at page 1446913, write from 'TC2' (0x54433200) (8)
[ 1044.915401] amdgpu 0000:0c:00.0: amdgpu: GPU fault detected: 147 0x00020802 for process firefox pid 6101 thread firefox:cs0 pid 6116
[ 1044.915405] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x0016BE00
[ 1044.915406] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x07008002
[ 1044.915407] amdgpu 0000:0c:00.0: amdgpu: VM fault (0x02, vmid 3, pasid 32780) at page 1490432, write from 'TC2' (0x54433200) (8)
[ 1059.900168] amdgpu 0000:0c:00.0: amdgpu: GPU fault detected: 147 0x00020802 for process firefox pid 6101 thread firefox:cs0 pid 6116
[ 1059.900172] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x0016F600
[ 1059.900173] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x09008002
[ 1059.900174] amdgpu 0000:0c:00.0: amdgpu: VM fault (0x02, vmid 4, pasid 32780) at page 1504768, write from 'TC2' (0x54433200) (8)
[ 3972.123585] amdgpu 0000:0c:00.0: amdgpu: GPU fault detected: 147 0x0ac20402 for process stellarium pid 8057 thread stellarium:cs0 pid 8060
[ 3972.123589] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x0010D958
[ 3972.123590] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x09004002
[ 3972.123591] amdgpu 0000:0c:00.0: amdgpu: VM fault (0x02, vmid 4, pasid 32781) at page 1104216, write from 'TC3' (0x54433300) (4)
[ 3972.123644] amdgpu 0000:0c:00.0: amdgpu: GPU fault detected: 147 0x0ada0802 for process stellarium pid 8057 thread stellarium:cs0 pid 8060
[ 3972.123645] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x0010D95B
[ 3972.123646] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x09008002
[ 3972.123646] amdgpu 0000:0c:00.0: amdgpu: VM fault (0x02, vmid 4, pasid 32781) at page 1104219, write from 'TC2' (0x54433200) (8)
[ 3972.124308] amdgpu 0000:0c:00.0: amdgpu: GPU fault detected: 147 0x02024802 for process stellarium pid 8057 thread stellarium:cs0 pid 8060
[ 3972.124309] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x0010DA40
[ 3972.124309] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x09048002
[ 3972.124310] amdgpu 0000:0c:00.0: amdgpu: VM fault (0x02, vmid 4, pasid 32781) at page 1104448, write from 'TC0' (0x54433000) (72)
[ 3972.124993] amdgpu 0000:0c:00.0: amdgpu: GPU fault detected: 147 0x0ac06202 for process stellarium pid 8057 thread stellarium:cs0 pid 8060
[ 3972.124994] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x0010D958
[ 3972.124995] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x08062002
[ 3972.124995] amdgpu 0000:0c:00.0: amdgpu: VM fault (0x02, vmid 4, pasid 32781) at page 1104216, read from 'CBC0' (0x43424330) (98)
[ 3972.124999] amdgpu 0000:0c:00.0: amdgpu: GPU fault detected: 147 0x0ac02202 for process stellarium pid 8057 thread stellarium:cs0 pid 8060
[ 3972.124999] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x0010D843
[ 3972.125000] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x09050002
[ 3972.125000] amdgpu 0000:0c:00.0: amdgpu: VM fault (0x02, vmid 4, pasid 32781) at page 1103939, write from 'CB1' (0x43423100) (80)
[ 3972.125004] amdgpu 0000:0c:00.0: amdgpu: GPU fault detected: 147 0x0ac01202 for process stellarium pid 8057 thread stellarium:cs0 pid 8060
[ 3972.125005] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x0010D891
[ 3972.125005] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x09010002
[ 3972.125005] amdgpu 0000:0c:00.0: amdgpu: VM fault (0x02, vmid 4, pasid 32781) at page 1104017, write from 'CB3' (0x43423300) (16)
[ 3972.125009] amdgpu 0000:0c:00.0: amdgpu: GPU fault detected: 147 0x0ac05202 for process stellarium pid 8057 thread stellarium:cs0 pid 8060
[ 3972.125010] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x0010D8CB
[ 3972.125010] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x09050002
[ 3972.125011] amdgpu 0000:0c:00.0: amdgpu: VM fault (0x02, vmid 4, pasid 32781) at page 1104075, write from 'CB1' (0x43423100) (80)
[ 3972.125015] amdgpu 0000:0c:00.0: amdgpu: GPU fault detected: 147 0x002a1002 for process stellarium pid 8057 thread stellarium:cs0 pid 8060
[ 3972.125015] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x0010D831
[ 3972.125016] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x09060002
[ 3972.125016] amdgpu 0000:0c:00.0: amdgpu: VM fault (0x02, vmid 4, pasid 32781) at page 1103921, write from 'CB0' (0x43423000) (96)
[ 3972.125020] amdgpu 0000:0c:00.0: amdgpu: GPU fault detected: 147 0x002a2002 for process stellarium pid 8057 thread stellarium:cs0 pid 8060
[ 3972.125021] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x0010D8B0
[ 3972.125021] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x09050002
[ 3972.125021] amdgpu 0000:0c:00.0: amdgpu: VM fault (0x02, vmid 4, pasid 32781) at page 1104048, write from 'CB1' (0x43423100) (80)
[ 3972.129482] amdgpu 0000:0c:00.0: amdgpu: GPU fault detected: 147 0x0ac04802 for process stellarium pid 8057 thread stellarium:cs0 pid 8060
[ 3972.129483] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x0010D958
[ 3972.129484] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x08048002
[ 3972.129484] amdgpu 0000:0c:00.0: amdgpu: VM fault (0x02, vmid 4, pasid 32781) at page 1104216, read from 'TC0' (0x54433000) (72)
[ 3979.889515] gmc_v8_0_process_interrupt: 530 callbacks suppressed
[ 3979.889519] amdgpu 0000:0c:00.0: amdgpu: GPU fault detected: 147 0x02020802 for process stellarium pid 8057 thread stellarium:cs0 pid 8060
[ 3979.889522] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00143C40
[ 3979.889523] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x05008002
[ 3979.889523] amdgpu 0000:0c:00.0: amdgpu: VM fault (0x02, vmid 2, pasid 32781) at page 1326144, write from 'TC2' (0x54433200) (8)
[ 3979.889975] amdgpu 0000:0c:00.0: amdgpu: GPU fault detected: 147 0x02001202 for process stellarium pid 8057 thread stellarium:cs0 pid 8060
[ 3979.889976] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00143C40
[ 3979.889977] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x04012002
[ 3979.889977] amdgpu 0000:0c:00.0: amdgpu: VM fault (0x02, vmid 2, pasid 32781) at page 1326144, read from 'CBC3' (0x43424333) (18)
[ 3979.889982] amdgpu 0000:0c:00.0: amdgpu: GPU fault detected: 147 0x02002202 for process stellarium pid 8057 thread stellarium:cs0 pid 8060
[ 3979.889983] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00143C05
[ 3979.889983] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x05020002
[ 3979.889984] amdgpu 0000:0c:00.0: amdgpu: VM fault (0x02, vmid 2, pasid 32781) at page 1326085, write from 'CB2' (0x43423200) (32)
[ 3979.889988] amdgpu 0000:0c:00.0: amdgpu: GPU fault detected: 147 0x02005202 for process stellarium pid 8057 thread stellarium:cs0 pid 8060
[ 3979.889989] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00143C07
[ 3979.889989] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x05050002
[ 3979.889990] amdgpu 0000:0c:00.0: amdgpu: VM fault (0x02, vmid 2, pasid 32781) at page 1326087, write from 'CB1' (0x43423100) (80)
[ 3979.889994] amdgpu 0000:0c:00.0: amdgpu: GPU fault detected: 147 0x02006202 for process stellarium pid 8057 thread stellarium:cs0 pid 8060
[ 3979.889995] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00143C15
[ 3979.889995] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x05010002
[ 3979.889995] amdgpu 0000:0c:00.0: amdgpu: VM fault (0x02, vmid 2, pasid 32781) at page 1326101, write from 'CB3' (0x43423300) (16)
[ 3979.890000] amdgpu 0000:0c:00.0: amdgpu: GPU fault detected: 147 0x002a2002 for process stellarium pid 8057 thread stellarium:cs0 pid 8060
[ 3979.890001] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00143C19
[ 3979.890001] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x05010002
[ 3979.890002] amdgpu 0000:0c:00.0: amdgpu: VM fault (0x02, vmid 2, pasid 32781) at page 1326105, write from 'CB3' (0x43423300) (16)
[ 3979.890006] amdgpu 0000:0c:00.0: amdgpu: GPU fault detected: 147 0x002a1002 for process stellarium pid 8057 thread stellarium:cs0 pid 8060
[ 3979.890007] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00143C30
[ 3979.890007] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x05010002
[ 3979.890007] amdgpu 0000:0c:00.0: amdgpu: VM fault (0x02, vmid 2, pasid 32781) at page 1326128, write from 'CB3' (0x43423300) (16)
[ 3979.890012] amdgpu 0000:0c:00.0: amdgpu: GPU fault detected: 147 0x000a2002 for process stellarium pid 8057 thread stellarium:cs0 pid 8060
[ 3979.890013] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00143C32
[ 3979.890013] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x05010002
[ 3979.890014] amdgpu 0000:0c:00.0: amdgpu: VM fault (0x02, vmid 2, pasid 32781) at page 1326130, write from 'CB3' (0x43423300) (16)
[ 3979.890017] amdgpu 0000:0c:00.0: amdgpu: GPU fault detected: 147 0x000a1002 for process stellarium pid 8057 thread stellarium:cs0 pid 8060
[ 3979.890018] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00143C28
[ 3979.890018] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x05010002
[ 3979.890019] amdgpu 0000:0c:00.0: amdgpu: VM fault (0x02, vmid 2, pasid 32781) at page 1326120, write from 'CB3' (0x43423300) (16)
[ 3979.891937] amdgpu 0000:0c:00.0: amdgpu: GPU fault detected: 147 0x02000802 for process stellarium pid 8057 thread stellarium:cs0 pid 8060
[ 3979.891937] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00143C40
[ 3979.891938] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x04008002
[ 3979.891938] amdgpu 0000:0c:00.0: amdgpu: VM fault (0x02, vmid 2, pasid 32781) at page 1326144, read from 'TC2' (0x54433200) (8)
[ 4062.912573] gmc_v8_0_process_interrupt: 2 callbacks suppressed
[ 4062.912578] amdgpu 0000:0c:00.0: amdgpu: GPU fault detected: 147 0x00004802 for process stellarium pid 8057 thread stellarium:cs0 pid 8060
[ 4062.912580] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00000800
[ 4062.912581] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x06048002
[ 4062.912582] amdgpu 0000:0c:00.0: amdgpu: VM fault (0x02, vmid 3, pasid 32781) at page 2048, read from 'TC0' (0x54433000) (72)
------------------------------------------------------------------------

There does not seem to be any apparent immediate problem with graphics
but when running commit babf0bb978e3, there seemed to be a noticeable
lag in some operations, e.g. when moving a window or repainting large
part of the terminal window in konsole (no idea if it's related).

My GPU is Radeon Pro WX 2100 (1002:6995). What other information should
I collect to help debugging the issue?

Michal Kubecek

--gtypyrxkzavvymbx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmKQky8ACgkQ538sG/LR
dpUKJQf/YzsEap7IRIvU+02H7WbM2LDPPf8ANiZeZGrDRamVjENFE+APOhQGt8gj
HpydLfoN0AGWz0EMut2eXj7HZPjApn6OHNob6A1GTRAFMWOWFcpQmwBwIAH+jcKz
MepA0vM7qUnvdQ9MV2ZlF7jIl7SEZVD1FZWPeWXYea+KetKI9WG5XGi5CMIrvF8q
hLrN1WY6im5DH8dRmimOhGAaGG1WnZaU8d8ffa8Zygx19f4u6GC3icTWsXdLTL7l
fHk5o2ljNeyWxZhs2oqetu/OhHBELuGrcM8p1YS2/6/tJWc1UkXG4q8063pjpjWB
j0WtMNXk/LIzsm8WFyTbseHDOEot4g==
=b/CJ
-----END PGP SIGNATURE-----

--gtypyrxkzavvymbx--

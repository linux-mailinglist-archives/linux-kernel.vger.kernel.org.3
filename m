Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D9F463E0B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 19:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245625AbhK3Sx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 13:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245621AbhK3SxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 13:53:13 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC2BC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:49:52 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 13so42909719ljj.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R0XVwWI0CDDryaRAyrcVHRt6GWu/D/+Wb5DibCwyPj8=;
        b=uhNYgiyPXG0gGAKEZ5PDwbzHU6/5W4MwrHbVw9Q6Fadx+bCVBZrysvoh2Vp4K1P3e0
         XTqNeNU2IgN4RZLHNNjOcva7OyS2EE6dd0tm+ZrfjlxL6dKY30ZL4xVXQe4eVLH90J87
         HjR3YngRRuPK9TdVJmqNNfVi0jIwrSqlVmuy8ExKCKWnL8Oct9ru1/zcZ8uf/P8CSQS3
         xHcWuenCP83gZe1EM6MuGe5uJBldxvwZ2YRnVzeTZOZ8Bdv6TJEpFwpM89o8AOLW51Ho
         73DCfS9jKYcwQWgjZgCFGgwyQgKQu9yg4AO0M8CGW73EDwrceHjvRxKWKMjDh4jgaILn
         JN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R0XVwWI0CDDryaRAyrcVHRt6GWu/D/+Wb5DibCwyPj8=;
        b=c1i6z7ooy33zsM0qalnxA8tpVw47FmgziuLReKjPd99UCkQf0dbHsGIOfCsI/KTv6+
         PQdsS5ByzF6xFjGtbxjemjIp7ckLmGe4rLUX/jialnAjN0f98hm8kEgV6ugX3x1YiR5r
         4y2qgQO0fdTrMxOwuZ+6hJIaLo2N9uh0fXxGGTYKRce3EU91Ih69ekhfNM8EizwaULSV
         +sk3hjqybs8frarcDTWUVraKP7+ZVNHOWh2mMkc/8BFKDrcGNN6FBOruqIShEfi4dely
         1/fHcHo00slYlfZ/hBleFrARHaU+mnxSKcQkjEyaJS79aDlbCV+WXD69kIcYXwmpo6zS
         64dQ==
X-Gm-Message-State: AOAM533UTgIH0LgkU6oDmq6Gh8K0HWbif/2h8Lm86TWkPSyrFzA5coEW
        9ST0STkt57GqVFbJzV4n8ZiZJA==
X-Google-Smtp-Source: ABdhPJxKHcxiQM0382WVNTj8j4caEFaktjfqod9dQqOdNnvSm7hP8KeJmxSqDyBdFJrFQntA5NMmuw==
X-Received: by 2002:a2e:9e10:: with SMTP id e16mr726764ljk.492.1638298190838;
        Tue, 30 Nov 2021 10:49:50 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id t12sm1780266ljg.63.2021.11.30.10.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 10:49:48 -0800 (PST)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 9189F103666; Tue, 30 Nov 2021 21:49:49 +0300 (+03)
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Nakajima, Jun" <jun.nakajima@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv4 0/4] Add generic MMIO instruction deconding to be used in SEV and TDX
Date:   Tue, 30 Nov 2021 21:49:29 +0300
Message-Id: <20211130184933.31005-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both AMD SEV and Intel TDX has to decode MMIO instruction to be able to
handle MMIO.

Extract insn_decode_mmio() from SEV code. TDX will also use this helper.

v4:
 - Use enum mmio_type inside insn_decode_mmio() (Tom)
 - Keep a comment in vc_handle_mmio() (Tom)
 - Tested-by on AMD HW from Joerg.
v3:
 - Handle insn_get_opcode() in is_string_insn()
v2:
 - insn_get_modrm_reg_ptr() returns unsigned long pointer now (PeterZ);
 - Handle insn_get_opcode() failure in insn_decode_mmio() (PeterZ);


Kirill A. Shutemov (4):
  x86/insn-eval: Handle insn_get_opcode() failure
  x86/insn-eval: Introduce insn_get_modrm_reg_ptr()
  x86/insn-eval: Introduce insn_decode_mmio()
  x86/sev-es: Use insn_decode_mmio() for MMIO implementation

 arch/x86/include/asm/insn-eval.h |  13 +++
 arch/x86/kernel/sev.c            | 172 ++++++++-----------------------
 arch/x86/lib/insn-eval.c         | 109 +++++++++++++++++++-
 3 files changed, 161 insertions(+), 133 deletions(-)

-- 
2.32.0

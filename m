Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D7D481C2B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 13:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239339AbhL3MpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 07:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbhL3MpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 07:45:20 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E4FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 04:45:20 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id i3so57435254ybh.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 04:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=7QQ+LViX1xJmyfGt1TBQo3SNgHM+wAiJ1GWPgnQDejU=;
        b=W0XVuzgIodcl/MssZ6arMB/0c780Rp68nBWqDTGiFYiqSTHetLNn8oLqkNQPyNlUmj
         Ub9UJH0FsgjjXLL27+UxcHzZepn47Udj2dMYc8BBrAGJB4e5hA0ZAEwD6Hf1mY414oqt
         TVkv2YYRJOAvUlgBVqRlhVH+wJ6FAxoEJJ0iAKlVyZLnJt8xf8U86Q8wttiV3XJCzfI7
         KJAwO5/aaBIGSX8uMLIoPmWNC4q30k4Wx7vrCSdIfDP64WZy2f4kFuYB1OOTiW+3jsm6
         UALWdl2gOZJAaMTuYsFTFWfS9HLA7dKtZQmillFrA1ujFf5FqvFhcSluESBUtSn2xMk/
         Ze+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=7QQ+LViX1xJmyfGt1TBQo3SNgHM+wAiJ1GWPgnQDejU=;
        b=Y9yL1KcEsmvuWoAMe54O/M0oLLrqfI8vzhFgkII6in4HonYagdwinrvEwHHMawVm5b
         f0DrzONYFMgERb7U4/j1fwkO3LVfg8BW/M5KGY1NSRyQzfSiSGR7hvTZKd4yNH3Ckpve
         YUFz22lyJD75jAlH4e3Su5Lhrf8QoAhCwgQv1kPejDeWUX5EU0Cq1a+mLL+q94bweODf
         QaojEZLRUSCmUAKSlXiXC8w3+GgKDkamNLCQCMJXtseRS/M1o57pECLvwVwkN340WAVn
         bvXadOEZiAVUzdciy6rtXwvbArxcwk8b1M2NHEVMsWSUrjbqLcWJstAYml7waioPZagI
         W+MQ==
X-Gm-Message-State: AOAM531X/05vlBaGy6nytWI4rNLAM6rigirQWQT36lWNl+s206x/Nics
        7ZQ4yJ02JltqR7mZNVfrUviv+Mgj+krLRfvMLCxUm3S6Z9c=
X-Google-Smtp-Source: ABdhPJx7F9hWbk2+VrsTTavkSOE7Fb1q0HeMraodq/ZFCNk6CK44adzxR6MQ1RlWU4WWDXFjekWBLDFJ7SkkM3RdBfk=
X-Received: by 2002:a25:2cd0:: with SMTP id s199mr24018954ybs.234.1640868319320;
 Thu, 30 Dec 2021 04:45:19 -0800 (PST)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 30 Dec 2021 13:45:08 +0100
Message-ID: <CAKXUXMxKj_d+Nb25rsukj0u2_06KB3+OVWfkYqNzWQG67S=rgw@mail.gmail.com>
Subject: Reference to non-existing config LOGIC_IOMEM_FALLBACK
To:     Johannes Berg <johannes.berg@intel.com>,
        Richard Weinberger <richard@nod.at>,
        Arnd Bergmann <arnd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Johannes, dear Richard,

In commit ca2e334232b6 ("lib: add iomem emulation (logic_iomem)"), you
have added an ifdef on the non-existing config LOGIC_IOMEM_FALLBACK in
./lib/logic_iomem.c.

In the commit message, you note:

    To use, an architecture must 'select LOGIC_IOMEM' in Kconfig
    and then include <asm-generic/logic_io.h> into asm/io.h to get
    the __raw_read*/__raw_write* functions.

    Optionally, an architecture may 'select LOGIC_IOMEM_FALLBACK'
    in which case non-emulated regions will 'fall back' to the
    various real_* functions that must then be provided.

This config LOGIC_IOMEM and config LOGIC_IOMEM_FALLBACK is however not
defined in any Kconfig file in the current repository.

Did you mean that the architecture shall select INDIRECT_IOMEM and
INDIRECT_IOMEM_FALLBACK, which were defined in your commit, and the
questionable ifdef in ./lib/logic_iomem.c needs to be changed to
INDIRECT_IOMEM_FALLBACK?
Or, are we simply missing the definitions for the config LOGIC_IOMEM
and LOGIC_IOMEM_FALLBACK?

This issue was identified with the script ./scripts/checkkconfigsymbols.py.

Best regards,

Lukas

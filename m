Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD8A4972B1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 16:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238022AbiAWPoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 10:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238020AbiAWPoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 10:44:54 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7F1C06173B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 07:44:53 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id a13so9116989wrh.9
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 07:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nfUCrgltiuESmGAEDtw9bdfISibes8TAv+qKIXGxuic=;
        b=Zz1rjr+Oaa1cFDW4Ogh1s0Dc6tRdjPe3+yJjgn9CXxfzgEto8FZ+qBc5OOqQt+wg2g
         86VMddvrTwe3r5BvseJWhSMizn31JbvnKgcrDhig3JnZk2XCLXgzqSWUC8NhyhnFEHQK
         0FP1z/IIQY1a0DG8xZ6zAWheMH4h2tsovocf5EFaEYtIY04+mKB3Y6qB986mMyv3y8Zv
         9ftdyp/cOWHazPHa9Zw6WnzHDb9q/rJgkv7k6VhCc30hD+4ZhueqoZcV5oLRNWJoJbyW
         rM+QaanVdc47C5HuUlHcN5c2Ekg8LZhLqcWlk/wBjm4g33CRo5QHhKE4uZaghxiD5MRn
         3zvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nfUCrgltiuESmGAEDtw9bdfISibes8TAv+qKIXGxuic=;
        b=TvMvU2sZStq7ZNuBbXRSb64jS415tzuFuNfToW4YslncbSX2Gi/qzqcIfnH02TteaJ
         SUSz2VgZC9eCOztVzThT8FX4dbdiGx3LnslSY/MBzUGzSkWgx4hrFyT+kG2I6AsIsmGm
         LK0DZuHu8cgoqdMXeOZ4LoZNN1odfJ8YV/HeEYtjaDiJRqIdq/T+6yeEMb+t7HSW7DhB
         hjnTvlH0l7VOGZ8Ucxds5syJerA/6ogc3wIVH4+Y+D/JW4jT3sBFDuau/+Ez5T+PIStX
         tIwOC1XqNpUx5E52lXGGUjjhvaL/PCMTx2V7WGRTXyXFBUwTaBadX7JEAihCWjleEK3C
         WBZQ==
X-Gm-Message-State: AOAM532B4SlVSPfEZzQI+fDfmVC8viaXP1BTDyovcOm+xoou0EWNykxs
        C3rXTkJrqNHoJ0pgNsK5ubV2MQ==
X-Google-Smtp-Source: ABdhPJwuMCafdMGqKQ6AEE1aYdBVnMGozvO8SH5XCkPG9PcCYPue5hINzJBa4ikKxPcemlyvyMc8ZQ==
X-Received: by 2002:adf:f192:: with SMTP id h18mr358315wro.314.1642952692393;
        Sun, 23 Jan 2022 07:44:52 -0800 (PST)
Received: from smtpclient.apple (global-5-142.nat-2.net.cam.ac.uk. [131.111.5.142])
        by smtp.gmail.com with ESMTPSA id l7sm13366441wrs.104.2022.01.23.07.44.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jan 2022 07:44:52 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH v2] Fixed: Misaligned memory access. Fixed pointer
 comparison.
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20220123034518.3717116-1-michael@michaelkloos.com>
Date:   Sun, 23 Jan 2022 15:44:51 +0000
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <485047B2-E566-4679-87CF-C4B3CAFEF108@jrtc27.com>
References: <20220123034518.3717116-1-michael@michaelkloos.com>
To:     "Michael T. Kloos" <michael@michaelkloos.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Jan 2022, at 03:45, Michael T. Kloos <michael@michaelkloos.com> =
wrote:
>=20
> Rewrote the riscv memmove() assembly implementation.  The
> previous implementation did not check memory alignment and it
> compared 2 pointers with a signed comparison.  The misaligned
> memory access would cause the kernel to crash on systems that
> did not emulate it in firmware and did not support it in hardware.
> Firmware emulation is slow and may not exist.  Additionally,
> hardware support may not exist and would likely still run slower
> than aligned accesses even if it did.  The RISC-V spec does not
> guarantee that support for misaligned memory accesses will exist.
> It should not be depended on.
>=20
> This patch now checks for the maximum granularity of co-alignment
> between the pointers and copies them with that, using single-byte
> copy for any unaligned data at their terminations.  It also now uses
> unsigned comparison for the pointers.
>=20
> Added half-word and, if built for 64-bit, double-word copy.
>=20
> Migrated to the	newer assembler annotations from the now =
deprecated
> ones.
>=20
> Commit Message Edited on Jan 22 2022: Fixed some typos.
>=20
> [v2]
>=20
> Per kernel test robot, I have fixed the build under clang.  This
> was broken due to a difference between gcc and clang, clang requiring
> explict zero offsets the jalr instruction. gcc allowed them to be
> omitted if zero.

Unlike LLVM, GCC does not have an assembler, that=E2=80=99s binutils=E2=80=
=99s GNU as.

Jess


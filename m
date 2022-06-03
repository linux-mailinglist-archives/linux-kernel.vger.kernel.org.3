Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2C153CA28
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 14:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244363AbiFCMrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 08:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244381AbiFCMr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 08:47:29 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D615626B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 05:47:27 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e2so10308178wrc.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 05:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ernKh7q0koX2BgfmbtKyvN+sg+w6Vr7ESQoRzLB3iMc=;
        b=JRjI1YhO3OMnpJqoPgRm8jo8atjsJf/awv7LDrMgBEmraIDVecraxoyzrdvif7TeZv
         p/rpk5pKcsMRxcL06Z/8LLrLgqe4K9iEfIVst1W+y3URe9T7WIzz+DgjaKI7lgsx1E5Y
         IdJkC5eXVEctg7X5aiZ0lFomxlxG1mhz1Z0W9Gyjb1TscH+ZW69wlO8wwo/bpqQzInIn
         9m6rMB/aSHVKrcy1L0k4ZBmauPmWGWZfIRSULDQ751gFI1T+eUZmWEBiRMcFNV7XJtA1
         ew4P+TNEBUC7L1NdTzDDvB3tlmRTtGc1idpKzCRnzEw1GMTE9JIhT5Lq9zi2f/3ToMmH
         EukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ernKh7q0koX2BgfmbtKyvN+sg+w6Vr7ESQoRzLB3iMc=;
        b=MwYusyx6NtVd45UytIeICVrWdFqgZve6wxfH0wXy+jZNUr3kItMxGW1okinE3tBJMR
         xwZkQw7fh72GfNQ9tbR932ifprmyFvgeNEaa39c6hJpsKGOB0qQmX/fyajtUq9DH5y4v
         h9a0XXJgwC9hjBz9Fgit+A/7wbD6qxPlieObCMStLxuxt7r6W8cODxDDDBKHe8IgR/n1
         f4NlfeUVr3dDNlnU8a13ku/mbY0wlqjofNfgdN71IK3ENdpouga/B7Kmj7WB/FusWiQR
         kh81ZCROsUxojRO/Y7uBUL72NoGzGB+K7xeUOyhQHLpDejE6/43UoXu987fudBAMTa3+
         e/lA==
X-Gm-Message-State: AOAM533/Vj9gP2aOg2TQeaRxD7eHzm3rKUGkG+o8JTXk3Tqr+f145dQ5
        e9OwiBJfMWT6kLNtaWoGX13Mbkcx8meiZrLLrWFSNw==
X-Google-Smtp-Source: ABdhPJzA3MAsqbhrglKAnMzFv+rkvY0j8WZELmwPb8U9af72b+nK0qRcTfi5bQ7VIe9dd3ua7OB3k8UPZqsTk16C9i4=
X-Received: by 2002:a5d:6481:0:b0:20f:ed13:f28d with SMTP id
 o1-20020a5d6481000000b0020fed13f28dmr7965679wri.719.1654260444757; Fri, 03
 Jun 2022 05:47:24 -0700 (PDT)
MIME-Version: 1.0
From:   Michael Schaller <misch@google.com>
Date:   Fri, 3 Jun 2022 14:46:48 +0200
Message-ID: <CALt099JajMVCwHgdRdRSF1uhNC=EO+tTq4T4Bg8QDwUO3uX83w@mail.gmail.com>
Subject: New partition on loop device doesn't appear in /dev anymore with
 kernel 5.17.0 and newer (repro script included)
To:     axboe@kernel.dk
Cc:     hch@lst.de, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000002d888805e08a8672"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000002d888805e08a8672
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear maintainer,

Since kernel 5.17.0 it appears that creating a partition on a loop
device doesn't automatically create the corresponding /dev/loop#p#
entry anymore. We rolled back to kernel 5.16.18, which doesn't have
this issue. I also tested kernel 5.18.1 and it is affected as well.

I've attached repro.sh, which is a Bash script that reproduces the
issue (tested on Debian testing). The script only requires standard
Linux tools (including GNU Parted). The script creates a raw disk
image file (sparse), associates the file with a loop device and
partitions the loop device so that it only contains an ESP. At this
point there should be a /dev/loop#p1 entry so that the following
mkfs.vfat can create the filesystem for the ESP. However on kernel
5.17.0 and newer /dev/loop#p1 isn't created and mkfs.vfat fails with
"No such file or directory". Furthermore on kernel 5.17.0 and newer we
see the following error in the kernel log: "I/O error, dev loop#,
sector 32640 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0"

I also did a kernel bisect against the vanilla stable kernels and that
revealed commit 1ebe2e5f9d68e94c524aba876f27b945669a7879 as the first
problematic commit. I've cc'ed the commit author as well.

This issue is also tracked on the Debian side with
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1012298.

Best,

Michael Schaller
Site Reliability Engineer - Software Engineer
misch@google.com

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

--0000000000002d888805e08a8672
Content-Type: application/x-shellscript; name="repro.sh"
Content-Disposition: attachment; filename="repro.sh"
Content-Transfer-Encoding: base64
Content-ID: <f_l3yfw9qh0>
X-Attachment-Id: f_l3yfw9qh0

IyEvYmluL2Jhc2gKCnNldCAtZXgKCmlmIFtbICIke0VVSUR9IiAhPSAwIF1dOyB0aGVuCiAgPiYy
IGVjaG8gInJvb3QgcmlnaHRzIHJlcXVpcmVkIgogIGV4aXQgMgpmaQoKaW1nPScvdG1wL3Jhdy5p
bWcnICAjIFJhdyBkaXNrIGltYWdlIGZpbGUuCmRldj0nJyAgIyBMb29wIGRldmljZSBhc3NvY2lh
dGVkIHdpdGggdGhlIHJhdyBkaXNrIGltYWdlIGZpbGUuCgpmdW5jdGlvbiBjbGVhbnVwIHsKICBz
ZXQgK2UKICBybSAtcmYgIiR7cmVzfSIKICBybSAtZiAiJHtjZmd9IgogIGlmIFsgLW4gIiR7ZGV2
fSIgXTsgdGhlbgogICAgIyBGcmVlIGxvb3AgZGV2aWNlLgogICAgbG9zZXR1cCAtLWRldGFjaCAi
JHtkZXZ9IgogIGZpCiAgcm0gLWYgIiR7aW1nfSIKfQp0cmFwIGNsZWFudXAgRVhJVAoKIyBDcmVh
dGUgc3BhcnNlIGZpbGUgZm9yIGEgcmF3IGRpc2sgaW1hZ2UuCmRkIGlmPS9kZXYvemVybyBzdGF0
dXM9bm9uZSBvZj0iJHtpbWd9IiBicz0xIGNvdW50PTAgc2Vlaz0xNk1pQgoKIyBBc3NvY2lhdGUg
YSBsb29wIGRldmljZSB3aXRoIHRoZSByYXcgZGlzayBpbWFnZS4KbG9zZXR1cCAtLWZpbmQgIiR7
aW1nfSIKCiMgR2V0IHRoZSBhc3NvY2lhdGVkIGxvb3AgZGV2aWNlLgpkZXY9JChsb3NldHVwIC0t
YXNzb2NpYXRlZCAiJHtpbWd9IiB8IGN1dCAtZCAnOicgLWYgMSkKaWYgWyAteiAiJHtkZXZ9IiBd
OyB0aGVuCiAgPiYyIGVjaG8gJ2ZhaWxlZCB0byBmaW5kIGFzc29jaWF0ZWQgbG9vcCBkZXZpY2Un
CiAgZXhpdCAxCmZpCgojIENyZWF0ZSBHUFQgcGFydGl0aW9uIHRhYmxlIHdpdGggYW4gRVNQLgpw
YXJ0ZWQgLXMgIiR7ZGV2fSIgbWtsYWJlbCBncHQKcGFydGVkIC1zICIke2Rldn0iIG1rcGFydCBw
cmltYXJ5ICJmYXQzMiIgMU1pQiAxMDAlCnBhcnRlZCAtcyAiJHtkZXZ9IiBzZXQgMSBib290IG9u
CnBhcnRwcm9iZSAiJHtkZXZ9IiAgIyBGb3IgZ29vZCBtZWFzdXJlIGJ1dCBub3QgbmVlZGVkIG9u
IGtlcm5lbCA1LjE2Cm1rZnMudmZhdCAgIiR7ZGV2fXAxIiAgIyBUaGlzIGNvbW1hbmQgZmFpbHMg
d2l0aCBrZXJuZWwgNS4xNwo=
--0000000000002d888805e08a8672--

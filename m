Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10148570A26
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 20:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiGKSxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 14:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiGKSxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 14:53:05 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5CC5C941
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 11:53:03 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b26so8198599wrc.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 11:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vcZtX6104M57u10leJ/RepZuGU6okX9h8KuXFj/t2Kw=;
        b=VWvMimmxN8lGZnlu+I3jOYr23jNzp07Dho9ZRqu0Ch7A+OlDdSnu+7L9dg63Th3SZ0
         7Z4TMW4XneIlZO3EsJBTB8zZb1NnDq/SqSAmwuH6dYyNxyQuy1gobifpZUCME1x+ALpF
         Aaz9ikAKoj8m+/6CrWc5W4YKfwPicOUPzGZdxtMZy4zwJvr7rL7Md9NKdlQHSWghz3ue
         vcPRgS+CzP0iJXZuM+stlkXFXwsyaKZ90mCNku0vAb8vY5fHqyTbb5DG4PkTuKlmFTQN
         2zAqh1DuHnSbQRPG7SSS7W7ePdiJwnHf1Loa8XCNYqJhqJbq7aSdvLhkYNfVTU2QZ0HE
         m4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vcZtX6104M57u10leJ/RepZuGU6okX9h8KuXFj/t2Kw=;
        b=xrzt8+tm6aa72kEJQt0ddZDdxJE6aCOuYAwIuDr7Ttl4Okh7EHxH58WfxUBAP+WP3p
         yzedJ3jqoKfijDn4kVKRRf9S1DuATXZrqMu8XwzaSoQFe3PN2EnuIpumvRy+s/219WmE
         DvxhhHsRmQC9MAGrCDc/dIt4Yryv6lAyNuXYbLc11ktQi0BIdW03O+iT+fhFb+jHjCCC
         4OJP47lzRqiICx0QDhE0bKxDdic/DN93JTpkoQC3HLj/VDCXv6j1R2HJoxzIFsyPgFFL
         aXy1d13E3sWZc2c0tABdI/R1+bxr1jGHqM61+dgrMoX2SkJB3OFZX10pOJYeIbasuiUL
         mx7A==
X-Gm-Message-State: AJIora91ocLUoPDX0jxBGhIehKXoXP49X/nV/D+arZIGX/F86Nluhsn7
        Jb61IWRR9WWdbv4+Kk2vGSM=
X-Google-Smtp-Source: AGRyM1tLP7H67NxOPb391qnDI6SztSbd80kEDyiG/3bXZAk7e+T2eNqSVS7bnQgrj4d9lMSraOSM2A==
X-Received: by 2002:a5d:474f:0:b0:21d:9a9b:a1fb with SMTP id o15-20020a5d474f000000b0021d9a9ba1fbmr12058168wrs.115.1657565581301;
        Mon, 11 Jul 2022 11:53:01 -0700 (PDT)
Received: from opensuse.localnet (host-95-235-102-55.retail.telecomitalia.it. [95.235.102.55])
        by smtp.gmail.com with ESMTPSA id d20-20020a05600c4c1400b003a1980d55c4sm10355849wmp.47.2022.07.11.11.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 11:52:59 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nick Terrell <terrelln@fb.com>, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] firmware_loader: Replace kmap() with kmap_local_page()
Date:   Mon, 11 Jul 2022 20:52:49 +0200
Message-ID: <2140056.NgBsaNRSFp@opensuse>
In-Reply-To: <Ysq+rpkTU1/nquHo@kroah.com>
References: <20220710101156.26139-1-fmdefrancesco@gmail.com> <1891319.taCxCBeP46@opensuse> <Ysq+rpkTU1/nquHo@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On domenica 10 luglio 2022 13:57:34 CEST Greg Kroah-Hartman wrote:
> On Sun, Jul 10, 2022 at 01:18:16PM +0200, Fabio M. De Francesco wrote:
> > On domenica 10 luglio 2022 12:24:41 CEST Greg Kroah-Hartman wrote:
> > > On Sun, Jul 10, 2022 at 12:11:56PM +0200, Fabio M. De Francesco=20
wrote:
> > > > The use of kmap() is being deprecated in favor of=20
kmap_local_page().
> > > >=20
> > > > With kmap_local_page() the mappings are per thread, CPU local, can=
=20
take
> > > > page faults, and can be called from any context (including=20
interrupts).
> > >=20
> > > But that is not the case here for this kmap() instance?
> >=20
> > I'm not 100% sure to get what you are asking here :-)
> > Probably you mean that kmap() can work here and you don't see reason=20
for=20
> > converting? Am I understanding correctly?
>=20
> Yes, that is what I am saying, why is this conversion needed here?  A
> justification would be nice.
>=20
> > OK, then...
> >=20
> > kmap() is being deprecated in favor of kmap_local_page(). Please see=20
> > highmem.rst which I have updated weeks ago (https://docs.kernel.org/vm/
> > highmem.html).
> >=20
> > Two main problems with kmap(): (1) It comes with an overhead as mapping=
=20
> > space is restricted and protected by a global lock for synchronization=
=20
and=20
> > (2) kmap() also requires global TLB invalidation when the kmap=E2=80=99=
s pool=20
wraps=20
> > and it might block when the mapping space is fully utilized until a=20
slot=20
> > becomes available.
> >=20
> > kmap_local_page() should be preferred, where feasible, over all the=20
others.
>=20
> Ok, that is good to know, thanks for the pointer, you should put this in
> the changelog text for maintainers who did not know this (like myself)
> as it makes it easier to review.
>=20
> > > If this is a
> > > simple search/replace, why is this not just done once and be done=20
with
> > > it?
> >=20
> > No, this job needs code inspection. After more than 25 conversions I=20
can=20
> > say that no more than 30% have been simple search and replace.
> >=20
> > > > Call kmap_local_page() in firmware_loader wherever kmap() is=20
currently
> > > > used. In firmware_rw() use the copy_{from,to}_page() helpers=20
instead of
> > > > open coding the local mappings plus memcpy().
> > >=20
> > > Isn't that just a different cleanup than the kmap() change?  Or is=20
that
> > > tied to the fact that the other buffer is now allocated with
> > > kmap_local_page() instead of kmap()?
> >=20
> > This kinds of changes have never been considered clean-ups by other=20
> > maintainers (for an example please see commit e88a6a8fece9 ("binder:=20
Use=20
> > memcpy_{to,from}_page() in binder_alloc_do_buffer_copy()").=20
> >=20
> > Using helpers has always been considered part of the conversions=20
themselves=20
> > and nobody has ever requested further patches for these.
> >=20
> > > > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > > ---
> > > >  drivers/base/firmware_loader/main.c  | 4 ++--
> > > >  drivers/base/firmware_loader/sysfs.c | 9 ++++-----
> > > >  2 files changed, 6 insertions(+), 7 deletions(-)
> > >=20
> > > Did you run this through the firmware test framework?
> >=20
> > No, sorry. I assumed (wrongly?) that this is one of those cases which=20
don't=20
> > need any tests. However I have nothing against testing. I've done them=
=20
> > where they were absolutely needed for Btrfs conversions and kexec.
>=20
> Running the kernel selftests for firmware would be great, please do so
> for your next version of this patch that fixes the
> ktest-robot-found-issues.
>=20
> thanks,
>=20
> greg k-h
>=20
Greg,

According to your requests, I extended the changelog text adding those=20
information about why kmap() should be avoided. Then I deleted that unused=
=20
variable which I had overlooked and finally tested with firmware selftests.

I see that the outputs of selftests, regardless of running a 5.19.0-rc6 =20
kernel with or without my changes, show always the same error:

"not ok 1 selftests: firmware: fw_run_tests.sh # TIMEOUT 165 seconds".".

I ran those tests on a QEMU/KVM 32-bits VM, booting a vanilla 5.19.0-rc6=20
kernel with HIGHMEM64GB enabled.=20

As said, outputs don't change with or without my patch. Instead it changes=
=20
with the latest openSUSE stock kernel (5.18.9-2-pae):

"ok 1 selftests: firmware: fw_run_tests.sh".

Unfortunately, I'm not familiar with kernel selftests. Any ideas about what=
=20
could have made this tests fail? Is it expected?=20

If not, I can try and figure out why these outputs are not what they should=
=20
be (the second version of my patch can wait the time it takes).

Thanks,

=46abio

P.S.: Whoever wants to read the entire log of the selftests is welcome :-)

xp4ns3@tweed32:/usr/src/git/linux> sudo make -C tools/testing/selftests=20
TARGETS=3Dfirmware run_tests
[sudo] password for root:=20
make: Entering directory '/usr/src/git/linux/tools/testing/selftests'
make --no-builtin-rules ARCH=3Dx86 -C ../../.. headers_install
make[1]: Entering directory '/usr/src/git/linux'
  INSTALL ./usr/include
make[1]: Leaving directory '/usr/src/git/linux'
make[1]: Entering directory '/usr/src/git/linux/tools/testing/selftests/
firmware'
make[1]: Nothing to be done for 'all'.
make[1]: Leaving directory '/usr/src/git/linux/tools/testing/selftests/
firmware'
make[1]: Entering directory '/usr/src/git/linux/tools/testing/selftests/
firmware'
TAP version 13
1..1
# selftests: firmware: fw_run_tests.sh
# Running namespace test:=20
# Testing with firmware in parent namespace (assumed to be same file system=
=20
as PID1)
# Testing with firmware in child namespace
# OK
# -----------------------------------------------------
# Running kernel configuration test 1 -- rare
# Emulates:
# CONFIG_FW_LOADER=3Dy
# CONFIG_FW_LOADER_USER_HELPER=3Dn
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK=3Dn
# ./fw_filesystem.sh: filesystem loading works
# ./fw_filesystem.sh: async filesystem loading works
# ./fw_filesystem.sh: platform loading works
#=20
# Testing with the file present...
# Batched request_firmware() normal try #1: OK
# Batched request_firmware() normal try #2: OK
# Batched request_firmware() normal try #3: OK
# Batched request_firmware() normal try #4: OK
# Batched request_firmware() normal try #5: OK
# Batched request_firmware_into_buf() normal try #1: OK
# Batched request_firmware_into_buf() normal try #2: OK
# Batched request_firmware_into_buf() normal try #3: OK
# Batched request_firmware_into_buf() normal try #4: OK
# Batched request_firmware_into_buf() normal try #5: OK
# Batched request_firmware_direct() normal try #1: OK
# Batched request_firmware_direct() normal try #2: OK
# Batched request_firmware_direct() normal try #3: OK
# Batched request_firmware_direct() normal try #4: OK
# Batched request_firmware_direct() normal try #5: OK
# Batched request_firmware_nowait(uevent=3Dtrue) normal try #1: OK
# Batched request_firmware_nowait(uevent=3Dtrue) normal try #2: OK
# Batched request_firmware_nowait(uevent=3Dtrue) normal try #3: OK
# Batched request_firmware_nowait(uevent=3Dtrue) normal try #4: OK
# Batched request_firmware_nowait(uevent=3Dtrue) normal try #5: OK
# Batched request_firmware_nowait(uevent=3Dfalse) normal try #1: OK
# Batched request_firmware_nowait(uevent=3Dfalse) normal try #2: OK
# Batched request_firmware_nowait(uevent=3Dfalse) normal try #3: OK
# Batched request_firmware_nowait(uevent=3Dfalse) normal try #4: OK
# Batched request_firmware_nowait(uevent=3Dfalse) normal try #5: OK
# Test request_partial_firmware_into_buf() off=3D0 size=3D10: OK
# Test request_partial_firmware_into_buf() off=3D0 size=3D5: OK
# Test request_partial_firmware_into_buf() off=3D1 size=3D6: OK
# Test request_partial_firmware_into_buf() off=3D2 size=3D10: OK
#=20
# Testing with the file missing...
# Batched request_firmware() nofile try #1: OK
# Batched request_firmware() nofile try #2: OK
# Batched request_firmware() nofile try #3: OK
# Batched request_firmware() nofile try #4: OK
# Batched request_firmware() nofile try #5: OK
# Batched request_firmware_into_buf() nofile try #1: OK
# Batched request_firmware_into_buf() nofile try #2: OK
# Batched request_firmware_into_buf() nofile try #3: OK
# Batched request_firmware_into_buf() nofile try #4: OK
# Batched request_firmware_into_buf() nofile try #5: OK
# Batched request_firmware_direct() nofile try #1: OK
# Batched request_firmware_direct() nofile try #2: OK
# Batched request_firmware_direct() nofile try #3: OK
# Batched request_firmware_direct() nofile try #4: OK
# Batched request_firmware_direct() nofile try #5: OK
# Batched request_firmware_nowait(uevent=3Dtrue) nofile try #1: OK
# Batched request_firmware_nowait(uevent=3Dtrue) nofile try #2: OK
# Batched request_firmware_nowait(uevent=3Dtrue) nofile try #3: OK
# Batched request_firmware_nowait(uevent=3Dtrue) nofile try #4: OK
# Batched request_firmware_nowait(uevent=3Dtrue) nofile try #5: OK
# Batched request_firmware_nowait(uevent=3Dfalse) nofile try #1: OK
# Batched request_firmware_nowait(uevent=3Dfalse) nofile try #2: OK
# Batched request_firmware_nowait(uevent=3Dfalse) nofile try #3: OK
# Batched request_firmware_nowait(uevent=3Dfalse) nofile try #4: OK
# Batched request_firmware_nowait(uevent=3Dfalse) nofile try #5: OK
# Test request_partial_firmware_into_buf() off=3D0 size=3D10 nofile: OK
# Test request_partial_firmware_into_buf() off=3D0 size=3D5 nofile: OK
# Test request_partial_firmware_into_buf() off=3D1 size=3D6 nofile: OK
# Test request_partial_firmware_into_buf() off=3D2 size=3D10 nofile: OK
#=20
# Testing with both plain and XZ files present...
# Batched request_firmware() both try #1: OK
# Batched request_firmware() both try #2: OK
# Batched request_firmware() both try #3: OK
# Batched request_firmware() both try #4: OK
# Batched request_firmware() both try #5: OK
# Batched request_firmware_into_buf() both try #1: OK
# Batched request_firmware_into_buf() both try #2: OK
# Batched request_firmware_into_buf() both try #3: OK
# Batched request_firmware_into_buf() both try #4: OK
# Batched request_firmware_into_buf() both try #5: OK
# Batched request_firmware_direct() both try #1: OK
# Batched request_firmware_direct() both try #2: OK
# Batched request_firmware_direct() both try #3: OK
# Batched request_firmware_direct() both try #4: OK
# Batched request_firmware_direct() both try #5: OK
# Batched request_firmware_nowait(uevent=3Dtrue) both try #1: OK
# Batched request_firmware_nowait(uevent=3Dtrue) both try #2: OK
# Batched request_firmware_nowait(uevent=3Dtrue) both try #3: OK
# Batched request_firmware_nowait(uevent=3Dtrue) both try #4: OK
# Batched request_firmware_nowait(uevent=3Dtrue) both try #5: OK
# Batched request_firmware_nowait(uevent=3Dfalse) both try #1: OK
# Batched request_firmware_nowait(uevent=3Dfalse) both try #2: OK
# Batched request_firmware_nowait(uevent=3Dfalse) both try #3: OK
# Batched request_firmware_nowait(uevent=3Dfalse) both try #4: OK
# Batched request_firmware_nowait(uevent=3Dfalse) both try #5: OK
#=20
# Testing with only XZ file present...
# Batched request_firmware() componly try #1: OK
# Batched request_firmware() componly try #2: OK
# Batched request_firmware() componly try #3: OK
# Batched request_firmware() componly try #4: OK
# Batched request_firmware() componly try #5: OK
# Batched request_firmware_into_buf() componly try #1: OK
# Batched request_firmware_into_buf() componly try #2: OK
# Batched request_firmware_into_buf() componly try #3: OK
# Batched request_firmware_into_buf() componly try #4: OK
# Batched request_firmware_into_buf() componly try #5: OK
# Batched request_firmware_direct() componly try #1: OK
# Batched request_firmware_direct() componly try #2: OK
# Batched request_firmware_direct() componly try #3: OK
# Batched request_firmware_direct() componly try #4: OK
# Batched request_firmware_direct() componly try #5: OK
# Batched request_firmware_nowait(uevent=3Dtrue) componly try #1: OK
# Batched request_firmware_nowait(uevent=3Dtrue) componly try #2: OK
# Batched request_firmware_nowait(uevent=3Dtrue) componly try #3: OK
# Batched request_firmware_nowait(uevent=3Dtrue) componly try #4: OK
# Batched request_firmware_nowait(uevent=3Dtrue) componly try #5: OK
# Batched request_firmware_nowait(uevent=3Dfalse) componly try #1: OK
# Batched request_firmware_nowait(uevent=3Dfalse) componly try #2: OK
# Batched request_firmware_nowait(uevent=3Dfalse) componly try #3: OK
# Batched request_firmware_nowait(uevent=3Dfalse) componly try #4: OK
# Batched request_firmware_nowait(uevent=3Dfalse) componly try #5: OK
#=20
# Testing with both plain and ZSTD files present...
# Batched request_firmware() both try #1: OK
# Batched request_firmware() both try #2: OK
# Batched request_firmware() both try #3: OK
# Batched request_firmware() both try #4: OK
# Batched request_firmware() both try #5: OK
# Batched request_firmware_into_buf() both try #1: OK
# Batched request_firmware_into_buf() both try #2: OK
# Batched request_firmware_into_buf() both try #3: OK
# Batched request_firmware_into_buf() both try #4: OK
# Batched request_firmware_into_buf() both try #5: OK
# Batched request_firmware_direct() both try #1: OK
# Batched request_firmware_direct() both try #2: OK
# Batched request_firmware_direct() both try #3: OK
# Batched request_firmware_direct() both try #4: OK
# Batched request_firmware_direct() both try #5: OK
# Batched request_firmware_nowait(uevent=3Dtrue) both try #1: OK
# Batched request_firmware_nowait(uevent=3Dtrue) both try #2: OK
# Batched request_firmware_nowait(uevent=3Dtrue) both try #3: OK
# Batched request_firmware_nowait(uevent=3Dtrue) both try #4: OK
# Batched request_firmware_nowait(uevent=3Dtrue) both try #5: OK
# Batched request_firmware_nowait(uevent=3Dfalse) both try #1: OK
# Batched request_firmware_nowait(uevent=3Dfalse) both try #2: OK
# Batched request_firmware_nowait(uevent=3Dfalse) both try #3: OK
# Batched request_firmware_nowait(uevent=3Dfalse) both try #4: OK
# Batched request_firmware_nowait(uevent=3Dfalse) both try #5: OK
#=20
# Testing with only ZSTD file present...
# Batched request_firmware() componly try #1: OK
# Batched request_firmware() componly try #2: OK
# Batched request_firmware() componly try #3: OK
# Batched request_firmware() componly try #4: OK
# Batched request_firmware() componly try #5: OK
# Batched request_firmware_into_buf() componly try #1: OK
# Batched request_firmware_into_buf() componly try #2: OK
# Batched request_firmware_into_buf() componly try #3: OK
# Batched request_firmware_into_buf() componly try #4: OK
# Batched request_firmware_into_buf() componly try #5: OK
# Batched request_firmware_direct() componly try #1: OK
# Batched request_firmware_direct() componly try #2: OK
# Batched request_firmware_direct() componly try #3: OK
# Batched request_firmware_direct() componly try #4: OK
# Batched request_firmware_direct() componly try #5: OK
# Batched request_firmware_nowait(uevent=3Dtrue) componly try #1: OK
# Batched request_firmware_nowait(uevent=3Dtrue) componly try #2: OK
# Batched request_firmware_nowait(uevent=3Dtrue) componly try #3: OK
# Batched request_firmware_nowait(uevent=3Dtrue) componly try #4: OK
# Batched request_firmware_nowait(uevent=3Dtrue) componly try #5: OK
# Batched request_firmware_nowait(uevent=3Dfalse) componly try #1: OK
# Batched request_firmware_nowait(uevent=3Dfalse) componly try #2: OK
# Batched request_firmware_nowait(uevent=3Dfalse) componly try #3: OK
# Batched request_firmware_nowait(uevent=3Dfalse) componly try #4: OK
# Batched request_firmware_nowait(uevent=3Dfalse) componly try #5: OK
#
not ok 1 selftests: firmware: fw_run_tests.sh # TIMEOUT 165 seconds
make[1]: Leaving directory '/usr/src/git/linux/tools/testing/selftests/
firmware'
make: Leaving directory '/usr/src/git/linux/tools/testing/selftests'




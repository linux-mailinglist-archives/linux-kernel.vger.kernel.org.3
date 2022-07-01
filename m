Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20225627C9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 02:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbiGAAlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 20:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiGAAlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 20:41:09 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413181AF2A;
        Thu, 30 Jun 2022 17:41:01 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LYxFh1HF1z4xD0;
        Fri,  1 Jul 2022 10:40:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1656636056;
        bh=Bn/f6/vuecr65Ku1Shmz63cOGi2zyB7CkNJ9wIK3pRs=;
        h=Date:From:To:Cc:Subject:From;
        b=EsfgxMMqXdOpl52U8nobcJLh82NKfhxJPfySpt9dmm6sEG+CG+AwwHpy0T6mpdOS3
         UYwaNWeTQwt7Ccbatzeoy/qEZaa4uhNfLxmA28UFNFtL3mc6p1ABM4iLHkcWxtGdTx
         NFSOHOr3mUPmuotMmi7JIvgdriThHSDAuOck/yka/OKaqAhrkiTyKZS1ksXbZkdNaQ
         eKiwOqevKOo1l3/g/c/K+nq0WYu+EHLxwVfdH9joqzDYJOx5Zs79QGw3Sd6Z92aG4b
         brRxqiEClff2C2UuW7ZFTq4+vVumD6du+iOO7vL0R1h4c+9m5CQPArPsOxne7gBj78
         XE9zmE1zz/Qgw==
Date:   Fri, 1 Jul 2022 10:36:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the scmi tree
Message-ID: <20220701103634.16114ec4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/dNQ9SFw=eeGPgmqQ4xV8/A0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/dNQ9SFw=eeGPgmqQ4xV8/A0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the scmi tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

In file included from <command-line>:
drivers/firmware/arm_scmi/powercap.c: In function 'scmi_powercap_measuremen=
ts_threshold_set':
include/linux/bits.h:35:29: warning: left shift count >=3D width of type [-=
Wshift-count-overflow]
   35 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
      |                             ^~
include/linux/compiler_types.h:332:23: note: in definition of macro '__comp=
iletime_assert'
  332 |                 if (!(condition))                                  =
     \
      |                       ^~~~~~~~~
include/linux/compiler_types.h:352:9: note: in expansion of macro '_compile=
time_assert'
  352 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_a=
ssert'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
include/linux/bitfield.h:65:17: note: in expansion of macro 'BUILD_BUG_ON_M=
SG'
   65 |                 BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),     =
     \
      |                 ^~~~~~~~~~~~~~~~
include/linux/bitfield.h:114:17: note: in expansion of macro '__BF_FIELD_CH=
ECK'
  114 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ")=
;    \
      |                 ^~~~~~~~~~~~~~~~
drivers/firmware/arm_scmi/powercap.c:556:18: note: in expansion of macro 'F=
IELD_PREP'
  556 |                  FIELD_PREP(GENMASK(63, 32), power_thresh_high));
      |                  ^~~~~~~~~~
include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |                                      ^~~~~~~~~
drivers/firmware/arm_scmi/powercap.c:556:29: note: in expansion of macro 'G=
ENMASK'
  556 |                  FIELD_PREP(GENMASK(63, 32), power_thresh_high));
      |                             ^~~~~~~
include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift=
-count-negative]
   36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
      |                  ^~
include/linux/compiler_types.h:332:23: note: in definition of macro '__comp=
iletime_assert'
  332 |                 if (!(condition))                                  =
     \
      |                       ^~~~~~~~~
include/linux/compiler_types.h:352:9: note: in expansion of macro '_compile=
time_assert'
  352 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_a=
ssert'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
include/linux/bitfield.h:65:17: note: in expansion of macro 'BUILD_BUG_ON_M=
SG'
   65 |                 BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),     =
     \
      |                 ^~~~~~~~~~~~~~~~
include/linux/bitfield.h:114:17: note: in expansion of macro '__BF_FIELD_CH=
ECK'
  114 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ")=
;    \
      |                 ^~~~~~~~~~~~~~~~
drivers/firmware/arm_scmi/powercap.c:556:18: note: in expansion of macro 'F=
IELD_PREP'
  556 |                  FIELD_PREP(GENMASK(63, 32), power_thresh_high));
      |                  ^~~~~~~~~~
include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |                                      ^~~~~~~~~
drivers/firmware/arm_scmi/powercap.c:556:29: note: in expansion of macro 'G=
ENMASK'
  556 |                  FIELD_PREP(GENMASK(63, 32), power_thresh_high));
      |                             ^~~~~~~
include/linux/bits.h:35:29: warning: left shift count >=3D width of type [-=
Wshift-count-overflow]
   35 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
      |                             ^~
include/linux/compiler_types.h:332:23: note: in definition of macro '__comp=
iletime_assert'
  332 |                 if (!(condition))                                  =
     \
      |                       ^~~~~~~~~
include/linux/compiler_types.h:352:9: note: in expansion of macro '_compile=
time_assert'
  352 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_a=
ssert'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
include/linux/bitfield.h:67:17: note: in expansion of macro 'BUILD_BUG_ON_M=
SG'
   67 |                 BUILD_BUG_ON_MSG((_mask) =3D=3D 0, _pfx "mask is ze=
ro");    \
      |                 ^~~~~~~~~~~~~~~~
include/linux/bitfield.h:114:17: note: in expansion of macro '__BF_FIELD_CH=
ECK'
  114 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ")=
;    \
      |                 ^~~~~~~~~~~~~~~~
drivers/firmware/arm_scmi/powercap.c:556:18: note: in expansion of macro 'F=
IELD_PREP'
  556 |                  FIELD_PREP(GENMASK(63, 32), power_thresh_high));
      |                  ^~~~~~~~~~
include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |                                      ^~~~~~~~~
drivers/firmware/arm_scmi/powercap.c:556:29: note: in expansion of macro 'G=
ENMASK'
  556 |                  FIELD_PREP(GENMASK(63, 32), power_thresh_high));
      |                             ^~~~~~~
include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift=
-count-negative]
   36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
      |                  ^~
include/linux/compiler_types.h:332:23: note: in definition of macro '__comp=
iletime_assert'
  332 |                 if (!(condition))                                  =
     \
      |                       ^~~~~~~~~
include/linux/compiler_types.h:352:9: note: in expansion of macro '_compile=
time_assert'
  352 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_a=
ssert'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
include/linux/bitfield.h:67:17: note: in expansion of macro 'BUILD_BUG_ON_M=
SG'
   67 |                 BUILD_BUG_ON_MSG((_mask) =3D=3D 0, _pfx "mask is ze=
ro");    \
      |                 ^~~~~~~~~~~~~~~~
include/linux/bitfield.h:114:17: note: in expansion of macro '__BF_FIELD_CH=
ECK'
  114 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ")=
;    \
      |                 ^~~~~~~~~~~~~~~~
drivers/firmware/arm_scmi/powercap.c:556:18: note: in expansion of macro 'F=
IELD_PREP'
  556 |                  FIELD_PREP(GENMASK(63, 32), power_thresh_high));
      |                  ^~~~~~~~~~
include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |                                      ^~~~~~~~~
drivers/firmware/arm_scmi/powercap.c:556:29: note: in expansion of macro 'G=
ENMASK'
  556 |                  FIELD_PREP(GENMASK(63, 32), power_thresh_high));
      |                             ^~~~~~~
include/linux/bits.h:35:29: warning: left shift count >=3D width of type [-=
Wshift-count-overflow]
   35 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
      |                             ^~
include/linux/compiler_types.h:332:23: note: in definition of macro '__comp=
iletime_assert'
  332 |                 if (!(condition))                                  =
     \
      |                       ^~~~~~~~~
include/linux/compiler_types.h:352:9: note: in expansion of macro '_compile=
time_assert'
  352 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_a=
ssert'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
include/linux/bitfield.h:68:17: note: in expansion of macro 'BUILD_BUG_ON_M=
SG'
   68 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?      =
     \
      |                 ^~~~~~~~~~~~~~~~
include/linux/bitfield.h:114:17: note: in expansion of macro '__BF_FIELD_CH=
ECK'
  114 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ")=
;    \
      |                 ^~~~~~~~~~~~~~~~
drivers/firmware/arm_scmi/powercap.c:556:18: note: in expansion of macro 'F=
IELD_PREP'
  556 |                  FIELD_PREP(GENMASK(63, 32), power_thresh_high));
      |                  ^~~~~~~~~~
include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |                                      ^~~~~~~~~
drivers/firmware/arm_scmi/powercap.c:556:29: note: in expansion of macro 'G=
ENMASK'
  556 |                  FIELD_PREP(GENMASK(63, 32), power_thresh_high));
      |                             ^~~~~~~
include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift=
-count-negative]
   36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
      |                  ^~
include/linux/compiler_types.h:332:23: note: in definition of macro '__comp=
iletime_assert'
  332 |                 if (!(condition))                                  =
     \
      |                       ^~~~~~~~~
include/linux/compiler_types.h:352:9: note: in expansion of macro '_compile=
time_assert'
  352 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_a=
ssert'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
include/linux/bitfield.h:68:17: note: in expansion of macro 'BUILD_BUG_ON_M=
SG'
   68 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?      =
     \
      |                 ^~~~~~~~~~~~~~~~
include/linux/bitfield.h:114:17: note: in expansion of macro '__BF_FIELD_CH=
ECK'
  114 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ")=
;    \
      |                 ^~~~~~~~~~~~~~~~
drivers/firmware/arm_scmi/powercap.c:556:18: note: in expansion of macro 'F=
IELD_PREP'
  556 |                  FIELD_PREP(GENMASK(63, 32), power_thresh_high));
      |                  ^~~~~~~~~~
include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |                                      ^~~~~~~~~
drivers/firmware/arm_scmi/powercap.c:556:29: note: in expansion of macro 'G=
ENMASK'
  556 |                  FIELD_PREP(GENMASK(63, 32), power_thresh_high));
      |                             ^~~~~~~
include/linux/bits.h:35:29: warning: left shift count >=3D width of type [-=
Wshift-count-overflow]
   35 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
      |                             ^~
include/linux/compiler_types.h:332:23: note: in definition of macro '__comp=
iletime_assert'
  332 |                 if (!(condition))                                  =
     \
      |                       ^~~~~~~~~
include/linux/compiler_types.h:352:9: note: in expansion of macro '_compile=
time_assert'
  352 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_a=
ssert'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
include/linux/bitfield.h:68:17: note: in expansion of macro 'BUILD_BUG_ON_M=
SG'
   68 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?      =
     \
      |                 ^~~~~~~~~~~~~~~~
include/linux/bitfield.h:69:47: note: in expansion of macro '__bf_shf'
   69 |                                  ~((_mask) >> __bf_shf(_mask)) & (_=
val) : 0, \
      |                                               ^~~~~~~~
include/linux/bitfield.h:114:17: note: in expansion of macro '__BF_FIELD_CH=
ECK'
  114 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ")=
;    \
      |                 ^~~~~~~~~~~~~~~~
drivers/firmware/arm_scmi/powercap.c:556:18: note: in expansion of macro 'F=
IELD_PREP'
  556 |                  FIELD_PREP(GENMASK(63, 32), power_thresh_high));
      |                  ^~~~~~~~~~
include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |                                      ^~~~~~~~~
drivers/firmware/arm_scmi/powercap.c:556:29: note: in expansion of macro 'G=
ENMASK'
  556 |                  FIELD_PREP(GENMASK(63, 32), power_thresh_high));
      |                             ^~~~~~~
include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift=
-count-negative]
   36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
      |                  ^~
include/linux/compiler_types.h:332:23: note: in definition of macro '__comp=
iletime_assert'
  332 |                 if (!(condition))                                  =
     \
      |                       ^~~~~~~~~
include/linux/compiler_types.h:352:9: note: in expansion of macro '_compile=
time_assert'
  352 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_a=
ssert'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
include/linux/bitfield.h:68:17: note: in expansion of macro 'BUILD_BUG_ON_M=
SG'
   68 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?      =
     \
      |                 ^~~~~~~~~~~~~~~~
include/linux/bitfield.h:69:47: note: in expansion of macro '__bf_shf'
   69 |                                  ~((_mask) >> __bf_shf(_mask)) & (_=
val) : 0, \
      |                                               ^~~~~~~~
include/linux/bitfield.h:114:17: note: in expansion of macro '__BF_FIELD_CH=
ECK'
  114 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ")=
;    \
      |                 ^~~~~~~~~~~~~~~~
drivers/firmware/arm_scmi/powercap.c:556:18: note: in expansion of macro 'F=
IELD_PREP'
  556 |                  FIELD_PREP(GENMASK(63, 32), power_thresh_high));
      |                  ^~~~~~~~~~
include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |                                      ^~~~~~~~~
drivers/firmware/arm_scmi/powercap.c:556:29: note: in expansion of macro 'G=
ENMASK'
  556 |                  FIELD_PREP(GENMASK(63, 32), power_thresh_high));
      |                             ^~~~~~~
include/linux/bits.h:35:29: warning: left shift count >=3D width of type [-=
Wshift-count-overflow]
   35 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
      |                             ^~
include/linux/compiler_types.h:332:23: note: in definition of macro '__comp=
iletime_assert'
  332 |                 if (!(condition))                                  =
     \
      |                       ^~~~~~~~~
include/linux/compiler_types.h:352:9: note: in expansion of macro '_compile=
time_assert'
  352 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_a=
ssert'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
include/linux/bitfield.h:71:17: note: in expansion of macro 'BUILD_BUG_ON_M=
SG'
   71 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >=
     \
      |                 ^~~~~~~~~~~~~~~~
include/linux/bitfield.h:71:34: note: in expansion of macro '__bf_cast_unsi=
gned'
   71 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >=
     \
      |                                  ^~~~~~~~~~~~~~~~~~
include/linux/bitfield.h:114:17: note: in expansion of macro '__BF_FIELD_CH=
ECK'
  114 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ")=
;    \
      |                 ^~~~~~~~~~~~~~~~
drivers/firmware/arm_scmi/powercap.c:556:18: note: in expansion of macro 'F=
IELD_PREP'
  556 |                  FIELD_PREP(GENMASK(63, 32), power_thresh_high));
      |                  ^~~~~~~~~~
include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |                                      ^~~~~~~~~
drivers/firmware/arm_scmi/powercap.c:556:29: note: in expansion of macro 'G=
ENMASK'
  556 |                  FIELD_PREP(GENMASK(63, 32), power_thresh_high));
      |                             ^~~~~~~
include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift=
-count-negative]
   36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
      |                  ^~
include/linux/compiler_types.h:332:23: note: in definition of macro '__comp=
iletime_assert'
  332 |                 if (!(condition))                                  =
     \
      |                       ^~~~~~~~~
include/linux/compiler_types.h:352:9: note: in expansion of macro '_compile=
time_assert'
  352 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_a=
ssert'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
include/linux/bitfield.h:71:17: note: in expansion of macro 'BUILD_BUG_ON_M=
SG'
   71 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >=
     \
      |                 ^~~~~~~~~~~~~~~~
include/linux/bitfield.h:71:34: note: in expansion of macro '__bf_cast_unsi=
gned'
   71 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >=
     \
      |                                  ^~~~~~~~~~~~~~~~~~
include/linux/bitfield.h:114:17: note: in expansion of macro '__BF_FIELD_CH=
ECK'
  114 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ")=
;    \
      |                 ^~~~~~~~~~~~~~~~
drivers/firmware/arm_scmi/powercap.c:556:18: note: in expansion of macro 'F=
IELD_PREP'
  556 |                  FIELD_PREP(GENMASK(63, 32), power_thresh_high));
      |                  ^~~~~~~~~~
include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |                                      ^~~~~~~~~
drivers/firmware/arm_scmi/powercap.c:556:29: note: in expansion of macro 'G=
ENMASK'
  556 |                  FIELD_PREP(GENMASK(63, 32), power_thresh_high));
      |                             ^~~~~~~
include/linux/bits.h:35:29: warning: left shift count >=3D width of type [-=
Wshift-count-overflow]
   35 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
      |                             ^~
include/linux/compiler_types.h:332:23: note: in definition of macro '__comp=
iletime_assert'
  332 |                 if (!(condition))                                  =
     \
      |                       ^~~~~~~~~
include/linux/compiler_types.h:352:9: note: in expansion of macro '_compile=
time_assert'
  352 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_a=
ssert'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_M=
SG'
   50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condit=
ion)
      |         ^~~~~~~~~~~~~~~~
include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
   21 |         BUILD_BUG_ON(((n) & ((n) - 1)) !=3D 0)
      |         ^~~~~~~~~~~~
include/linux/bitfield.h:74:17: note: in expansion of macro '__BUILD_BUG_ON=
_NOT_POWER_OF_2'
   74 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +            =
     \
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/bitfield.h:114:17: note: in expansion of macro '__BF_FIELD_CH=
ECK'
  114 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ")=
;    \
      |                 ^~~~~~~~~~~~~~~~
drivers/firmware/arm_scmi/powercap.c:556:18: note: in expansion of macro 'F=
IELD_PREP'
  556 |                  FIELD_PREP(GENMASK(63, 32), power_thresh_high));
      |                  ^~~~~~~~~~
include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |                                      ^~~~~~~~~
drivers/firmware/arm_scmi/powercap.c:556:29: note: in expansion of macro 'G=
ENMASK'
  556 |                  FIELD_PREP(GENMASK(63, 32), power_thresh_high));
      |                             ^~~~~~~
include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift=
-count-negative]
   36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
      |                  ^~
include/linux/compiler_types.h:332:23: note: in definition of macro '__comp=
iletime_assert'
  332 |                 if (!(condition))                                  =
     \
      |                       ^~~~~~~~~
include/linux/compiler_types.h:352:9: note: in expansion of macro '_compile=
time_assert'
  352 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_a=
ssert'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_M=
SG'
   50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condit=
ion)
      |         ^~~~~~~~~~~~~~~~
include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
   21 |         BUILD_BUG_ON(((n) & ((n) - 1)) !=3D 0)
      |         ^~~~~~~~~~~~
include/linux/bitfield.h:74:17: note: in expansion of macro '__BUILD_BUG_ON=
_NOT_POWER_OF_2'
   74 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +            =
     \
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/bitfield.h:114:17: note: in expansion of macro '__BF_FIELD_CH=
ECK'
  114 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ")=
;    \
      |                 ^~~~~~~~~~~~~~~~
drivers/firmware/arm_scmi/powercap.c:556:18: note: in expansion of macro 'F=
IELD_PREP'
  556 |                  FIELD_PREP(GENMASK(63, 32), power_thresh_high));
      |                  ^~~~~~~~~~
include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |                                      ^~~~~~~~~
drivers/firmware/arm_scmi/powercap.c:556:29: note: in expansion of macro 'G=
ENMASK'
  556 |                  FIELD_PREP(GENMASK(63, 32), power_thresh_high));
      |                             ^~~~~~~
include/linux/bits.h:35:29: warning: left shift count >=3D width of type [-=
Wshift-count-overflow]
   35 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
      |                             ^~
include/linux/compiler_types.h:332:23: note: in definition of macro '__comp=
iletime_assert'
  332 |                 if (!(condition))                                  =
     \
      |                       ^~~~~~~~~
include/linux/compiler_types.h:352:9: note: in expansion of macro '_compile=
time_assert'
  352 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_a=
ssert'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_M=
SG'
   50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condit=
ion)
      |         ^~~~~~~~~~~~~~~~
include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
   21 |         BUILD_BUG_ON(((n) & ((n) - 1)) !=3D 0)
      |         ^~~~~~~~~~~~
include/linux/bitfield.h:74:17: note: in expansion of macro '__BUILD_BUG_ON=
_NOT_POWER_OF_2'
   74 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +            =
     \
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/bitfield.h:75:56: note: in expansion of macro '__bf_shf'
   75 |                                               (1ULL << __bf_shf(_ma=
sk))); \
      |                                                        ^~~~~~~~
include/linux/bitfield.h:114:17: note: in expansion of macro '__BF_FIELD_CH=
ECK'
  114 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ")=
;    \
      |                 ^~~~~~~~~~~~~~~~
drivers/firmware/arm_scmi/powercap.c:556:18: note: in expansion of macro 'F=
IELD_PREP'
  556 |                  FIELD_PREP(GENMASK(63, 32), power_thresh_high));
      |                  ^~~~~~~~~~
include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |                                      ^~~~~~~~~
drivers/firmware/arm_scmi/powercap.c:556:29: note: in expansion of macro 'G=
ENMASK'
  556 |                  FIELD_PREP(GENMASK(63, 32), power_thresh_high));
      |                             ^~~~~~~
include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift=
-count-negative]
   36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
      |                  ^~
include/linux/compiler_types.h:332:23: note: in definition of macro '__comp=
iletime_assert'
  332 |                 if (!(condition))                                  =
     \
      |                       ^~~~~~~~~
include/linux/compiler_types.h:352:9: note: in expansion of macro '_compile=
time_assert'
  352 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_a=
ssert'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_M=
SG'
   50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condit=
ion)
      |         ^~~~~~~~~~~~~~~~
include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
   21 |         BUILD_BUG_ON(((n) & ((n) - 1)) !=3D 0)
      |         ^~~~~~~~~~~~
include/linux/bitfield.h:74:17: note: in expansion of macro '__BUILD_BUG_ON=
_NOT_POWER_OF_2'
   74 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +            =
     \
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/bitfield.h:75:56: note: in expansion of macro '__bf_shf'
   75 |                                               (1ULL << __bf_shf(_ma=
sk))); \
      |                                                        ^~~~~~~~
include/linux/bitfield.h:114:17: note: in expansion of macro '__BF_FIELD_CH=
ECK'
  114 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ")=
;    \
      |                 ^~~~~~~~~~~~~~~~
drivers/firmware/arm_scmi/powercap.c:556:18: note: in expansion of macro 'F=
IELD_PREP'
  556 |                  FIELD_PREP(GENMASK(63, 32), power_thresh_high));
      |                  ^~~~~~~~~~
include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |                                      ^~~~~~~~~
drivers/firmware/arm_scmi/powercap.c:556:29: note: in expansion of macro 'G=
ENMASK'
  556 |                  FIELD_PREP(GENMASK(63, 32), power_thresh_high));
      |                             ^~~~~~~
include/linux/bits.h:35:29: warning: left shift count >=3D width of type [-=
Wshift-count-overflow]
   35 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
      |                             ^~
include/linux/compiler_types.h:332:23: note: in definition of macro '__comp=
iletime_assert'
  332 |                 if (!(condition))                                  =
     \
      |                       ^~~~~~~~~
include/linux/compiler_types.h:352:9: note: in expansion of macro '_compile=
time_assert'
  352 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_a=
ssert'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_M=
SG'
   50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condit=
ion)
      |         ^~~~~~~~~~~~~~~~
include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
   21 |         BUILD_BUG_ON(((n) & ((n) - 1)) !=3D 0)
      |         ^~~~~~~~~~~~
include/linux/bitfield.h:74:17: note: in expansion of macro '__BUILD_BUG_ON=
_NOT_POWER_OF_2'
   74 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +            =
     \
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/bitfield.h:114:17: note: in expansion of macro '__BF_FIELD_CH=
ECK'
  114 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ")=
;    \
      |                 ^~~~~~~~~~~~~~~~
drivers/firmware/arm_scmi/powercap.c:556:18: note: in expansion of macro 'F=
IELD_PREP'
  556 |                  FIELD_PREP(GENMASK(63, 32), power_thresh_high));
      |                  ^~~~~~~~~~
include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |                                      ^~~~~~~~~
drivers/firmware/arm_scmi/powercap.c:556:29: note: in expansion of macro 'G=
ENMASK'
  556 |                  FIELD_PREP(GENMASK(63, 32), power_thresh_high));
      |                             ^~~~~~~
include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift=
-count-negative]
   36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
      |                  ^~
include/linux/compiler_types.h:332:23: note: in definition of macro '__comp=
iletime_assert'
  332 |                 if (!(condition))                                  =
     \
      |                       ^~~~~~~~~
include/linux/compiler_types.h:352:9: note: in expansion of macro '_compile=
time_assert'
  352 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_a=
ssert'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_M=
SG'
   50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condit=
ion)
      |         ^~~~~~~~~~~~~~~~
include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
   21 |         BUILD_BUG_ON(((n) & ((n) - 1)) !=3D 0)
      |         ^~~~~~~~~~~~
include/linux/bitfield.h:74:17: note: in expansion of macro '__BUILD_BUG_ON=
_NOT_POWER_OF_2'
   74 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +            =
     \
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/bitfield.h:114:17: note: in expansion of macro '__BF_FIELD_CH=
ECK'
  114 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ")=
;    \
      |                 ^~~~~~~~~~~~~~~~
drivers/firmware/arm_scmi/powercap.c:556:18: note: in expansion of macro 'F=
IELD_PREP'
  556 |                  FIELD_PREP(GENMASK(63, 32), power_thresh_high));
      |                  ^~~~~~~~~~
include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |                                      ^~~~~~~~~
drivers/firmware/arm_scmi/powercap.c:556:29: note: in expansion of macro 'G=
ENMASK'
  556 |                  FIELD_PREP(GENMASK(63, 32), power_thresh_high));
      |                             ^~~~~~~
include/linux/bits.h:35:29: warning: left shift count >=3D width of type [-=
Wshift-count-overflow]
   35 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
      |                             ^~
include/linux/compiler_types.h:332:23: note: in definition of macro '__comp=
iletime_assert'
  332 |                 if (!(condition))                                  =
     \
      |                       ^~~~~~~~~
include/linux/compiler_types.h:352:9: note: in expansion of macro '_compile=
time_assert'
  352 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_a=
ssert'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_M=
SG'
   50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condit=
ion)
      |         ^~~~~~~~~~~~~~~~
include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
   21 |         BUILD_BUG_ON(((n) & ((n) - 1)) !=3D 0)
      |         ^~~~~~~~~~~~
include/linux/bitfield.h:74:17: note: in expansion of macro '__BUILD_BUG_ON=
_NOT_POWER_OF_2'
   74 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +            =
     \
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/bitfield.h:75:56: note: in expansion of macro '__bf_shf'
   75 |                                               (1ULL << __bf_shf(_ma=
sk))); \
      |                                                        ^~~~~~~~
include/linux/bitfield.h:114:17: note: in expansion of macro '__BF_FIELD_CH=
ECK'
  114 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ")=
;    \
      |                 ^~~~~~~~~~~~~~~~
drivers/firmware/arm_scmi/powercap.c:556:18: note: in expansion of macro 'F=
IELD_PREP'
  556 |                  FIELD_PREP(GENMASK(63, 32), power_thresh_high));
      |                  ^~~~~~~~~~
include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |                                      ^~~~~~~~~
drivers/firmware/arm_scmi/powercap.c:556:29: note: in expansion of macro 'G=
ENMASK'
  556 |                  FIELD_PREP(GENMASK(63, 32), power_thresh_high));
      |                             ^~~~~~~
include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift=
-count-negative]
   36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
      |                  ^~
include/linux/compiler_types.h:332:23: note: in definition of macro '__comp=
iletime_assert'
  332 |                 if (!(condition))                                  =
     \
      |                       ^~~~~~~~~
include/linux/compiler_types.h:352:9: note: in expansion of macro '_compile=
time_assert'
  352 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_a=
ssert'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_M=
SG'
   50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condit=
ion)
      |         ^~~~~~~~~~~~~~~~
include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
   21 |         BUILD_BUG_ON(((n) & ((n) - 1)) !=3D 0)
      |         ^~~~~~~~~~~~
include/linux/bitfield.h:74:17: note: in expansion of macro '__BUILD_BUG_ON=
_NOT_POWER_OF_2'
   74 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +            =
     \
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/bitfield.h:75:56: note: in expansion of macro '__bf_shf'
   75 |                                               (1ULL << __bf_shf(_ma=
sk))); \
      |                                                        ^~~~~~~~
include/linux/bitfield.h:114:17: note: in expansion of macro '__BF_FIELD_CH=
ECK'
  114 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ")=
;    \
      |                 ^~~~~~~~~~~~~~~~
drivers/firmware/arm_scmi/powercap.c:556:18: note: in expansion of macro 'F=
IELD_PREP'
  556 |                  FIELD_PREP(GENMASK(63, 32), power_thresh_high));
      |                  ^~~~~~~~~~
include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |                                      ^~~~~~~~~
drivers/firmware/arm_scmi/powercap.c:556:29: note: in expansion of macro 'G=
ENMASK'
  556 |                  FIELD_PREP(GENMASK(63, 32), power_thresh_high));
      |                             ^~~~~~~
In file included from drivers/firmware/arm_scmi/powercap.c:10:
include/linux/bits.h:35:29: warning: left shift count >=3D width of type [-=
Wshift-count-overflow]
   35 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
      |                             ^~
include/linux/bitfield.h:45:38: note: in definition of macro '__bf_shf'
   45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
      |                                      ^
drivers/firmware/arm_scmi/powercap.c:556:18: note: in expansion of macro 'F=
IELD_PREP'
  556 |                  FIELD_PREP(GENMASK(63, 32), power_thresh_high));
      |                  ^~~~~~~~~~
include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |                                      ^~~~~~~~~
drivers/firmware/arm_scmi/powercap.c:556:29: note: in expansion of macro 'G=
ENMASK'
  556 |                  FIELD_PREP(GENMASK(63, 32), power_thresh_high));
      |                             ^~~~~~~
include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift=
-count-negative]
   36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
      |                  ^~
include/linux/bitfield.h:45:38: note: in definition of macro '__bf_shf'
   45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
      |                                      ^
drivers/firmware/arm_scmi/powercap.c:556:18: note: in expansion of macro 'F=
IELD_PREP'
  556 |                  FIELD_PREP(GENMASK(63, 32), power_thresh_high));
      |                  ^~~~~~~~~~
include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |                                      ^~~~~~~~~
drivers/firmware/arm_scmi/powercap.c:556:29: note: in expansion of macro 'G=
ENMASK'
  556 |                  FIELD_PREP(GENMASK(63, 32), power_thresh_high));
      |                             ^~~~~~~
include/linux/bits.h:35:29: warning: left shift count >=3D width of type [-=
Wshift-count-overflow]
   35 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
      |                             ^~
include/linux/bitfield.h:115:63: note: in definition of macro 'FIELD_PREP'
  115 |                 ((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask=
);   \
      |                                                               ^~~~~
include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |                                      ^~~~~~~~~
drivers/firmware/arm_scmi/powercap.c:556:29: note: in expansion of macro 'G=
ENMASK'
  556 |                  FIELD_PREP(GENMASK(63, 32), power_thresh_high));
      |                             ^~~~~~~
include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift=
-count-negative]
   36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
      |                  ^~
include/linux/bitfield.h:115:63: note: in definition of macro 'FIELD_PREP'
  115 |                 ((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask=
);   \
      |                                                               ^~~~~
include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |                                      ^~~~~~~~~
drivers/firmware/arm_scmi/powercap.c:556:29: note: in expansion of macro 'G=
ENMASK'
  556 |                  FIELD_PREP(GENMASK(63, 32), power_thresh_high));
      |                             ^~~~~~~
In file included from <command-line>:
include/linux/compiler_types.h:352:45: error: call to '__compiletime_assert=
_210' declared with attribute error: FIELD_PREP: mask is zero
  352 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |                                             ^
include/linux/compiler_types.h:333:25: note: in definition of macro '__comp=
iletime_assert'
  333 |                         prefix ## suffix();                        =
     \
      |                         ^~~~~~
include/linux/compiler_types.h:352:9: note: in expansion of macro '_compile=
time_assert'
  352 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_a=
ssert'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
include/linux/bitfield.h:67:17: note: in expansion of macro 'BUILD_BUG_ON_M=
SG'
   67 |                 BUILD_BUG_ON_MSG((_mask) =3D=3D 0, _pfx "mask is ze=
ro");    \
      |                 ^~~~~~~~~~~~~~~~
include/linux/bitfield.h:114:17: note: in expansion of macro '__BF_FIELD_CH=
ECK'
  114 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ")=
;    \
      |                 ^~~~~~~~~~~~~~~~
drivers/firmware/arm_scmi/powercap.c:556:18: note: in expansion of macro 'F=
IELD_PREP'
  556 |                  FIELD_PREP(GENMASK(63, 32), power_thresh_high));
      |                  ^~~~~~~~~~

Caused by commit

  14e527571502 ("firmware: arm_scmi: Add SCMIv3.1 Powercap protocol basic s=
upport")

I have used the scmi tree from next-20220630 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/dNQ9SFw=eeGPgmqQ4xV8/A0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmK+QZIACgkQAVBC80lX
0GzMLQgAnEcfcDWjXA3MYwxflEreJw6Tsy499jcCBDXV2RjVmXI5WB9MHo0gcN36
AdR/kYkq4668GsDalxMtfnosU0oprwdsoW042okFT/yHE3dw9/k9bejLB3+l18J4
FK3xTP4fC/I5vOcaSgk9VfrQnuiyeJh2ica8WY/cM+F+ykoZ6MBVLFHTFJCSPaIY
Mb75Rrh8v25DV3m81BRwCFLHU3hWN9u/iBhiMFSMncli5ZG7J2ktdAG0zqHlDEL+
ZTw3EAGJyfSAQ7eS8wfhdo6uRl0svD5kHGeS3Zf/o5EOGksR+PieyrgraQXCnQHK
9BbO9sAmff8ji9XmMwA7Nfw0cg+uWA==
=VdjP
-----END PGP SIGNATURE-----

--Sig_/dNQ9SFw=eeGPgmqQ4xV8/A0--

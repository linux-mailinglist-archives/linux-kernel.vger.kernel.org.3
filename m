Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1782058BB98
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 17:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbiHGPeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 11:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbiHGPeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 11:34:00 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FBF640C
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 08:33:57 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id i14so12539198ejg.6
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 08:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=T1SYU7I6mTymBKZiiI9UrCv3NPNDGUD3N4sZ7gprDhA=;
        b=BoNkrBqbT+0WBuPPCD2keZqI/7WVU6CThDjOzC4KYxSWwUGdPg5KQgT2emH1hAj2+S
         hginABogV2CW97uiFhwGuFhr7T9b3AuxbPhWJUnCdOgpZ6/vu0uBcq9nb04JibbqIayG
         /YTDu6f5hyzALirLy6KlNJPVobiYCoEJhSMLpSPoX7lVi9dpfxB2TpMo1xDnhLcvYYsR
         9vKqgIdLbW66Bbbk+yncnthKLzS3BsYnG37Bf5lm5isp6veHKylQTcpxq6BqncoHZS2o
         aYB7R88KpuB6adt3lTeG5WtepSm3HOV1uVzBfgh0H02A1WMREvR1/OuiGNs4Cxsph5X1
         IYeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=T1SYU7I6mTymBKZiiI9UrCv3NPNDGUD3N4sZ7gprDhA=;
        b=Zt5e02OJxRwY7mToXybu21ndsuUOUUsIft5r+5nZ7G9lS2KifuqPdrz1wKz58ponal
         UK1deJ+JlyjCKbKnEWP4L/0MbX8tRdVNePxVxEDPX9TX5oIogX0piPmzCfXF45Ejs+TL
         5Q1HWwR+fnUxDbNWL4Sp/aEPMj/ZvVlbotGXQYllGdVDwspU1HocHpdvHTTX+UBBJO8x
         UVE2Sq9rso3vNijBa2ut5RN8o+VoN67ZnMNQHjUBcHtMTaTybU713WAgLkySOv1tVcRh
         aIPUBbm4WQikdXR8gsyKIpi/gVB34PV8C869VNCeoqw+VjL/nJA7IxV+YsFAsjDet3kT
         MDmw==
X-Gm-Message-State: ACgBeo1PKBHgQ+Mky05oJoFSb/s4cX7PeghhvrqDWt/NkViP8BnnchUO
        bLVvYpOISl0ByQEaBNotU8UNlPSkrlGQF7uaZo4=
X-Google-Smtp-Source: AA6agR5B1FrjJynbNg4U69RHfaout06kSpAH3Gg7MjBRZ7aYinFu+RqHpK1N66Eb/0hqKUk3Lfg8CF0fiIRb8XB2n6M=
X-Received: by 2002:a17:907:7241:b0:72b:347b:17a1 with SMTP id
 ds1-20020a170907724100b0072b347b17a1mr11468434ejc.32.1659886435904; Sun, 07
 Aug 2022 08:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220804074730.GA3269@haolee.io> <202208072309.v3KZUmUA-lkp@intel.com>
In-Reply-To: <202208072309.v3KZUmUA-lkp@intel.com>
From:   Hao Lee <haolee.swjtu@gmail.com>
Date:   Sun, 7 Aug 2022 23:33:27 +0800
Message-ID: <CA+PpKP=NTsQ=0FNbSpGPhDvgHFjJeaRTddHMz+rDHhAVv1r6PA@mail.gmail.com>
Subject: Re: [PATCH] mm: add DEVICE_ZONE to FOR_ALL_ZONES
To:     kernel test robot <lkp@intel.com>
Cc:     akpm@linux-foundation.org, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, david@redhat.com,
        yang.shi@linux.alibaba.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I missed the situation when CONFIG_ZONE_DEVICE is not defined. Fixed in next v2.

On Sun, Aug 7, 2022 at 11:09 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Hao,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on akpm-mm/mm-everything]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Hao-Lee/mm-add-DEVICE_ZONE-to-FOR_ALL_ZONES/20220804-154805
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> config: hexagon-randconfig-r041-20220804 (https://download.01.org/0day-ci/archive/20220807/202208072309.v3KZUmUA-lkp@intel.com/config)
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 26dd42705c2af0b8f6e5d6cdb32c9bd5ed9524eb)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/dba18359aee97f43008e19ffa78421e652b1b102
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Hao-Lee/mm-add-DEVICE_ZONE-to-FOR_ALL_ZONES/20220804-154805
>         git checkout dba18359aee97f43008e19ffa78421e652b1b102
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/iio/adc/ fs/xfs/ ipc/
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>    In file included from fs/xfs/scrub/agheader.c:6:
>    In file included from fs/xfs/xfs.h:22:
>    In file included from fs/xfs/xfs_linux.h:24:
>    In file included from fs/xfs/kmem.h:11:
>    In file included from include/linux/mm.h:1668:
>    In file included from include/linux/vmstat.h:8:
>    include/linux/vm_event_item.h:33:3: error: expected identifier
>                    FOR_ALL_ZONES(PGALLOC),
>                    ^
>    include/linux/vm_event_item.h:29:27: note: expanded from macro 'FOR_ALL_ZONES'
>    #define FOR_ALL_ZONES(xx) (DMA_ZONE(xx) DMA32_ZONE(xx) xx##_NORMAL, \
>                              ^
>    include/linux/vm_event_item.h:34:3: error: expected identifier
>                    FOR_ALL_ZONES(ALLOCSTALL),
>                    ^
>    include/linux/vm_event_item.h:29:27: note: expanded from macro 'FOR_ALL_ZONES'
>    #define FOR_ALL_ZONES(xx) (DMA_ZONE(xx) DMA32_ZONE(xx) xx##_NORMAL, \
>                              ^
>    include/linux/vm_event_item.h:35:3: error: expected identifier
>                    FOR_ALL_ZONES(PGSCAN_SKIP),
>                    ^
>    include/linux/vm_event_item.h:29:27: note: expanded from macro 'FOR_ALL_ZONES'
>    #define FOR_ALL_ZONES(xx) (DMA_ZONE(xx) DMA32_ZONE(xx) xx##_NORMAL, \
>                              ^
> >> fs/xfs/scrub/agheader.c:165:32: warning: implicit conversion from 'int' to '__u16' (aka 'unsigned short') changes value from -49265 to 16271 [-Wconstant-conversion]
>                                      XFS_SB_VERSION_EXTFLGBIT |
>                                      ~~~~~~~~~~~~~~~~~~~~~~~~~^
>    include/linux/byteorder/generic.h:96:21: note: expanded from macro 'cpu_to_be16'
>    #define cpu_to_be16 __cpu_to_be16
>                        ^
>    include/uapi/linux/byteorder/little_endian.h:42:53: note: expanded from macro '__cpu_to_be16'
>    #define __cpu_to_be16(x) ((__force __be16)__swab16((x)))
>                                              ~~~~~~~~~~^~~
>    include/uapi/linux/swab.h:107:12: note: expanded from macro '__swab16'
>            __fswab16(x))
>            ~~~~~~~~~ ^
>    1 warning and 3 errors generated.
> --
>    In file included from ipc/msg.c:30:
>    In file included from include/linux/mm.h:1668:
>    In file included from include/linux/vmstat.h:8:
>    include/linux/vm_event_item.h:33:3: error: expected identifier
>                    FOR_ALL_ZONES(PGALLOC),
>                    ^
>    include/linux/vm_event_item.h:29:27: note: expanded from macro 'FOR_ALL_ZONES'
>    #define FOR_ALL_ZONES(xx) (DMA_ZONE(xx) DMA32_ZONE(xx) xx##_NORMAL, \
>                              ^
>    include/linux/vm_event_item.h:34:3: error: expected identifier
>                    FOR_ALL_ZONES(ALLOCSTALL),
>                    ^
>    include/linux/vm_event_item.h:29:27: note: expanded from macro 'FOR_ALL_ZONES'
>    #define FOR_ALL_ZONES(xx) (DMA_ZONE(xx) DMA32_ZONE(xx) xx##_NORMAL, \
>                              ^
>    include/linux/vm_event_item.h:35:3: error: expected identifier
>                    FOR_ALL_ZONES(PGSCAN_SKIP),
>                    ^
>    include/linux/vm_event_item.h:29:27: note: expanded from macro 'FOR_ALL_ZONES'
>    #define FOR_ALL_ZONES(xx) (DMA_ZONE(xx) DMA32_ZONE(xx) xx##_NORMAL, \
>                              ^
> >> ipc/msg.c:496:20: warning: implicit conversion from 'int' to 'unsigned short' changes value from 32768000 to 0 [-Wconstant-conversion]
>            msginfo->msgseg = MSGSEG;
>                            ~ ^~~~~~
>    include/uapi/linux/msg.h:87:38: note: expanded from macro 'MSGSEG'
>    #define MSGSEG (__MSGSEG <= 0xffff ? __MSGSEG : 0xffff)
>                                         ^~~~~~~~
>    include/uapi/linux/msg.h:86:36: note: expanded from macro '__MSGSEG'
>    #define __MSGSEG ((MSGPOOL * 1024) / MSGSSZ) /* max no. of segments */
>                      ~~~~~~~~~~~~~~~~~^~~~~~~~
>    1 warning and 3 errors generated.
> --
>    In file included from drivers/iio/adc/fsl-imx25-gcq.c:18:
>    In file included from include/linux/regulator/consumer.h:35:
>    In file included from include/linux/suspend.h:5:
>    In file included from include/linux/swap.h:9:
>    In file included from include/linux/memcontrol.h:14:
>    include/linux/vm_event_item.h:33:3: error: expected identifier
>                    FOR_ALL_ZONES(PGALLOC),
>                    ^
>    include/linux/vm_event_item.h:29:27: note: expanded from macro 'FOR_ALL_ZONES'
>    #define FOR_ALL_ZONES(xx) (DMA_ZONE(xx) DMA32_ZONE(xx) xx##_NORMAL, \
>                              ^
>    include/linux/vm_event_item.h:34:3: error: expected identifier
>                    FOR_ALL_ZONES(ALLOCSTALL),
>                    ^
>    include/linux/vm_event_item.h:29:27: note: expanded from macro 'FOR_ALL_ZONES'
>    #define FOR_ALL_ZONES(xx) (DMA_ZONE(xx) DMA32_ZONE(xx) xx##_NORMAL, \
>                              ^
>    include/linux/vm_event_item.h:35:3: error: expected identifier
>                    FOR_ALL_ZONES(PGSCAN_SKIP),
>                    ^
>    include/linux/vm_event_item.h:29:27: note: expanded from macro 'FOR_ALL_ZONES'
>    #define FOR_ALL_ZONES(xx) (DMA_ZONE(xx) DMA32_ZONE(xx) xx##_NORMAL, \
>                              ^
> >> drivers/iio/adc/fsl-imx25-gcq.c:115:8: warning: shift count is negative [-Wshift-count-negative]
>                         MX25_ADCQ_ITEM(0, chan->channel));
>                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/mfd/imx25-tsadc.h:54:3: note: expanded from macro 'MX25_ADCQ_ITEM'
>                    _MX25_ADCQ_ITEM((item) - 8, (x)) : _MX25_ADCQ_ITEM((item), (x)))
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/mfd/imx25-tsadc.h:52:39: note: expanded from macro '_MX25_ADCQ_ITEM'
>    #define _MX25_ADCQ_ITEM(item, x)        ((x) << ((item) * 4))
>                                                 ^  ~~~~~~~~~~~~
>    1 warning and 3 errors generated.
>
>
> vim +165 fs/xfs/scrub/agheader.c
>
> 166d76410d7ac0 Darrick J. Wong     2018-01-16   50
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17   51  /*
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17   52   * Scrub the filesystem superblock.
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17   53   *
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17   54   * Note: We do /not/ attempt to check AG 0's superblock.  Mount is
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17   55   * responsible for validating all the geometry information in sb 0, so
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17   56   * if the filesystem is capable of initiating online scrub, then clearly
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17   57   * sb 0 is ok and we can use its information to check everything else.
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17   58   */
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17   59  int
> c517b3aa02cff1 Darrick J. Wong     2018-07-19   60  xchk_superblock(
> 1d8a748a8aa94a Darrick J. Wong     2018-07-19   61      struct xfs_scrub        *sc)
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17   62  {
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17   63      struct xfs_mount        *mp = sc->mp;
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17   64      struct xfs_buf          *bp;
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17   65      struct xfs_dsb          *sb;
> 48c6615cc55759 Darrick J. Wong     2021-08-06   66      struct xfs_perag        *pag;
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17   67      xfs_agnumber_t          agno;
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17   68      uint32_t                v2_ok;
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17   69      __be32                  features_mask;
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17   70      int                     error;
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17   71      __be16                  vernum_mask;
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17   72
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17   73      agno = sc->sm->sm_agno;
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17   74      if (agno == 0)
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17   75              return 0;
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17   76
> 48c6615cc55759 Darrick J. Wong     2021-08-06   77      /*
> 48c6615cc55759 Darrick J. Wong     2021-08-06   78       * Grab an active reference to the perag structure.  If we can't get
> 48c6615cc55759 Darrick J. Wong     2021-08-06   79       * it, we're racing with something that's tearing down the AG, so
> 48c6615cc55759 Darrick J. Wong     2021-08-06   80       * signal that the AG no longer exists.
> 48c6615cc55759 Darrick J. Wong     2021-08-06   81       */
> 48c6615cc55759 Darrick J. Wong     2021-08-06   82      pag = xfs_perag_get(mp, agno);
> 48c6615cc55759 Darrick J. Wong     2021-08-06   83      if (!pag)
> 48c6615cc55759 Darrick J. Wong     2021-08-06   84              return -ENOENT;
> 48c6615cc55759 Darrick J. Wong     2021-08-06   85
> 689e11c84b1586 Darrick J. Wong     2018-05-14   86      error = xfs_sb_read_secondary(mp, sc->tp, agno, &bp);
> e5b37faa932d79 Darrick J. Wong     2018-01-08   87      /*
> e5b37faa932d79 Darrick J. Wong     2018-01-08   88       * The superblock verifier can return several different error codes
> e5b37faa932d79 Darrick J. Wong     2018-01-08   89       * if it thinks the superblock doesn't look right.  For a mount these
> e5b37faa932d79 Darrick J. Wong     2018-01-08   90       * would all get bounced back to userspace, but if we're here then the
> e5b37faa932d79 Darrick J. Wong     2018-01-08   91       * fs mounted successfully, which means that this secondary superblock
> e5b37faa932d79 Darrick J. Wong     2018-01-08   92       * is simply incorrect.  Treat all these codes the same way we treat
> e5b37faa932d79 Darrick J. Wong     2018-01-08   93       * any corruption.
> e5b37faa932d79 Darrick J. Wong     2018-01-08   94       */
> e5b37faa932d79 Darrick J. Wong     2018-01-08   95      switch (error) {
> e5b37faa932d79 Darrick J. Wong     2018-01-08   96      case -EINVAL:   /* also -EWRONGFS */
> e5b37faa932d79 Darrick J. Wong     2018-01-08   97      case -ENOSYS:
> e5b37faa932d79 Darrick J. Wong     2018-01-08   98      case -EFBIG:
> e5b37faa932d79 Darrick J. Wong     2018-01-08   99              error = -EFSCORRUPTED;
> 53004ee78d6273 Gustavo A. R. Silva 2021-04-20  100              fallthrough;
> e5b37faa932d79 Darrick J. Wong     2018-01-08  101      default:
> e5b37faa932d79 Darrick J. Wong     2018-01-08  102              break;
> e5b37faa932d79 Darrick J. Wong     2018-01-08  103      }
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  104      if (!xchk_process_error(sc, agno, XFS_SB_BLOCK(mp), &error))
> 48c6615cc55759 Darrick J. Wong     2021-08-06  105              goto out_pag;
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  106
> 3e6e8afd3abb74 Christoph Hellwig   2020-03-10  107      sb = bp->b_addr;
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  108
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  109      /*
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  110       * Verify the geometries match.  Fields that are permanently
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  111       * set by mkfs are checked; fields that can be updated later
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  112       * (and are not propagated to backup superblocks) are preen
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  113       * checked.
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  114       */
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  115      if (sb->sb_blocksize != cpu_to_be32(mp->m_sb.sb_blocksize))
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  116              xchk_block_set_corrupt(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  117
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  118      if (sb->sb_dblocks != cpu_to_be64(mp->m_sb.sb_dblocks))
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  119              xchk_block_set_corrupt(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  120
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  121      if (sb->sb_rblocks != cpu_to_be64(mp->m_sb.sb_rblocks))
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  122              xchk_block_set_corrupt(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  123
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  124      if (sb->sb_rextents != cpu_to_be64(mp->m_sb.sb_rextents))
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  125              xchk_block_set_corrupt(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  126
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  127      if (!uuid_equal(&sb->sb_uuid, &mp->m_sb.sb_uuid))
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  128              xchk_block_set_preen(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  129
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  130      if (sb->sb_logstart != cpu_to_be64(mp->m_sb.sb_logstart))
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  131              xchk_block_set_corrupt(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  132
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  133      if (sb->sb_rootino != cpu_to_be64(mp->m_sb.sb_rootino))
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  134              xchk_block_set_preen(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  135
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  136      if (sb->sb_rbmino != cpu_to_be64(mp->m_sb.sb_rbmino))
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  137              xchk_block_set_preen(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  138
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  139      if (sb->sb_rsumino != cpu_to_be64(mp->m_sb.sb_rsumino))
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  140              xchk_block_set_preen(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  141
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  142      if (sb->sb_rextsize != cpu_to_be32(mp->m_sb.sb_rextsize))
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  143              xchk_block_set_corrupt(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  144
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  145      if (sb->sb_agblocks != cpu_to_be32(mp->m_sb.sb_agblocks))
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  146              xchk_block_set_corrupt(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  147
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  148      if (sb->sb_agcount != cpu_to_be32(mp->m_sb.sb_agcount))
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  149              xchk_block_set_corrupt(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  150
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  151      if (sb->sb_rbmblocks != cpu_to_be32(mp->m_sb.sb_rbmblocks))
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  152              xchk_block_set_corrupt(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  153
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  154      if (sb->sb_logblocks != cpu_to_be32(mp->m_sb.sb_logblocks))
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  155              xchk_block_set_corrupt(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  156
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  157      /* Check sb_versionnum bits that are set at mkfs time. */
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  158      vernum_mask = cpu_to_be16(~XFS_SB_VERSION_OKBITS |
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  159                                XFS_SB_VERSION_NUMBITS |
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  160                                XFS_SB_VERSION_ALIGNBIT |
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  161                                XFS_SB_VERSION_DALIGNBIT |
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  162                                XFS_SB_VERSION_SHAREDBIT |
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  163                                XFS_SB_VERSION_LOGV2BIT |
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  164                                XFS_SB_VERSION_SECTORBIT |
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17 @165                                XFS_SB_VERSION_EXTFLGBIT |
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  166                                XFS_SB_VERSION_DIRV2BIT);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  167      if ((sb->sb_versionnum & vernum_mask) !=
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  168          (cpu_to_be16(mp->m_sb.sb_versionnum) & vernum_mask))
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  169              xchk_block_set_corrupt(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  170
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  171      /* Check sb_versionnum bits that can be set after mkfs time. */
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  172      vernum_mask = cpu_to_be16(XFS_SB_VERSION_ATTRBIT |
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  173                                XFS_SB_VERSION_NLINKBIT |
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  174                                XFS_SB_VERSION_QUOTABIT);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  175      if ((sb->sb_versionnum & vernum_mask) !=
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  176          (cpu_to_be16(mp->m_sb.sb_versionnum) & vernum_mask))
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  177              xchk_block_set_preen(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  178
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  179      if (sb->sb_sectsize != cpu_to_be16(mp->m_sb.sb_sectsize))
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  180              xchk_block_set_corrupt(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  181
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  182      if (sb->sb_inodesize != cpu_to_be16(mp->m_sb.sb_inodesize))
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  183              xchk_block_set_corrupt(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  184
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  185      if (sb->sb_inopblock != cpu_to_be16(mp->m_sb.sb_inopblock))
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  186              xchk_block_set_corrupt(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  187
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  188      if (memcmp(sb->sb_fname, mp->m_sb.sb_fname, sizeof(sb->sb_fname)))
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  189              xchk_block_set_preen(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  190
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  191      if (sb->sb_blocklog != mp->m_sb.sb_blocklog)
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  192              xchk_block_set_corrupt(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  193
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  194      if (sb->sb_sectlog != mp->m_sb.sb_sectlog)
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  195              xchk_block_set_corrupt(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  196
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  197      if (sb->sb_inodelog != mp->m_sb.sb_inodelog)
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  198              xchk_block_set_corrupt(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  199
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  200      if (sb->sb_inopblog != mp->m_sb.sb_inopblog)
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  201              xchk_block_set_corrupt(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  202
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  203      if (sb->sb_agblklog != mp->m_sb.sb_agblklog)
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  204              xchk_block_set_corrupt(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  205
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  206      if (sb->sb_rextslog != mp->m_sb.sb_rextslog)
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  207              xchk_block_set_corrupt(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  208
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  209      if (sb->sb_imax_pct != mp->m_sb.sb_imax_pct)
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  210              xchk_block_set_preen(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  211
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  212      /*
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  213       * Skip the summary counters since we track them in memory anyway.
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  214       * sb_icount, sb_ifree, sb_fdblocks, sb_frexents
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  215       */
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  216
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  217      if (sb->sb_uquotino != cpu_to_be64(mp->m_sb.sb_uquotino))
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  218              xchk_block_set_preen(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  219
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  220      if (sb->sb_gquotino != cpu_to_be64(mp->m_sb.sb_gquotino))
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  221              xchk_block_set_preen(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  222
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  223      /*
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  224       * Skip the quota flags since repair will force quotacheck.
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  225       * sb_qflags
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  226       */
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  227
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  228      if (sb->sb_flags != mp->m_sb.sb_flags)
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  229              xchk_block_set_corrupt(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  230
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  231      if (sb->sb_shared_vn != mp->m_sb.sb_shared_vn)
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  232              xchk_block_set_corrupt(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  233
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  234      if (sb->sb_inoalignmt != cpu_to_be32(mp->m_sb.sb_inoalignmt))
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  235              xchk_block_set_corrupt(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  236
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  237      if (sb->sb_unit != cpu_to_be32(mp->m_sb.sb_unit))
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  238              xchk_block_set_preen(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  239
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  240      if (sb->sb_width != cpu_to_be32(mp->m_sb.sb_width))
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  241              xchk_block_set_preen(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  242
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  243      if (sb->sb_dirblklog != mp->m_sb.sb_dirblklog)
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  244              xchk_block_set_corrupt(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  245
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  246      if (sb->sb_logsectlog != mp->m_sb.sb_logsectlog)
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  247              xchk_block_set_corrupt(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  248
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  249      if (sb->sb_logsectsize != cpu_to_be16(mp->m_sb.sb_logsectsize))
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  250              xchk_block_set_corrupt(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  251
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  252      if (sb->sb_logsunit != cpu_to_be32(mp->m_sb.sb_logsunit))
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  253              xchk_block_set_corrupt(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  254
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  255      /* Do we see any invalid bits in sb_features2? */
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  256      if (!xfs_sb_version_hasmorebits(&mp->m_sb)) {
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  257              if (sb->sb_features2 != 0)
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  258                      xchk_block_set_corrupt(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  259      } else {
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  260              v2_ok = XFS_SB_VERSION2_OKBITS;
> d6837c1aab42e7 Dave Chinner        2021-08-18  261              if (xfs_sb_is_v5(&mp->m_sb))
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  262                      v2_ok |= XFS_SB_VERSION2_CRCBIT;
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  263
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  264              if (!!(sb->sb_features2 & cpu_to_be32(~v2_ok)))
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  265                      xchk_block_set_corrupt(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  266
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  267              if (sb->sb_features2 != sb->sb_bad_features2)
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  268                      xchk_block_set_preen(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  269      }
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  270
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  271      /* Check sb_features2 flags that are set at mkfs time. */
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  272      features_mask = cpu_to_be32(XFS_SB_VERSION2_LAZYSBCOUNTBIT |
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  273                                  XFS_SB_VERSION2_PROJID32BIT |
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  274                                  XFS_SB_VERSION2_CRCBIT |
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  275                                  XFS_SB_VERSION2_FTYPE);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  276      if ((sb->sb_features2 & features_mask) !=
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  277          (cpu_to_be32(mp->m_sb.sb_features2) & features_mask))
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  278              xchk_block_set_corrupt(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  279
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  280      /* Check sb_features2 flags that can be set after mkfs time. */
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  281      features_mask = cpu_to_be32(XFS_SB_VERSION2_ATTR2BIT);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  282      if ((sb->sb_features2 & features_mask) !=
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  283          (cpu_to_be32(mp->m_sb.sb_features2) & features_mask))
> 4a9bca86806fa6 Darrick J. Wong     2022-01-07  284              xchk_block_set_preen(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  285
> 38c26bfd90e199 Dave Chinner        2021-08-18  286      if (!xfs_has_crc(mp)) {
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  287              /* all v5 fields must be zero */
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  288              if (memchr_inv(&sb->sb_features_compat, 0,
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  289                              sizeof(struct xfs_dsb) -
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  290                              offsetof(struct xfs_dsb, sb_features_compat)))
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  291                      xchk_block_set_corrupt(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  292      } else {
> 4a9bca86806fa6 Darrick J. Wong     2022-01-07  293              /* compat features must match */
> 4a9bca86806fa6 Darrick J. Wong     2022-01-07  294              if (sb->sb_features_compat !=
> 4a9bca86806fa6 Darrick J. Wong     2022-01-07  295                              cpu_to_be32(mp->m_sb.sb_features_compat))
> 4a9bca86806fa6 Darrick J. Wong     2022-01-07  296                      xchk_block_set_corrupt(sc, bp);
> 4a9bca86806fa6 Darrick J. Wong     2022-01-07  297
> 4a9bca86806fa6 Darrick J. Wong     2022-01-07  298              /* ro compat features must match */
> 4a9bca86806fa6 Darrick J. Wong     2022-01-07  299              if (sb->sb_features_ro_compat !=
> 4a9bca86806fa6 Darrick J. Wong     2022-01-07  300                              cpu_to_be32(mp->m_sb.sb_features_ro_compat))
> 4a9bca86806fa6 Darrick J. Wong     2022-01-07  301                      xchk_block_set_corrupt(sc, bp);
> 4a9bca86806fa6 Darrick J. Wong     2022-01-07  302
> 4a9bca86806fa6 Darrick J. Wong     2022-01-07  303              /*
> 4a9bca86806fa6 Darrick J. Wong     2022-01-07  304               * NEEDSREPAIR is ignored on a secondary super, so we should
> 4a9bca86806fa6 Darrick J. Wong     2022-01-07  305               * clear it when we find it, though it's not a corruption.
> 4a9bca86806fa6 Darrick J. Wong     2022-01-07  306               */
> 4a9bca86806fa6 Darrick J. Wong     2022-01-07  307              features_mask = cpu_to_be32(XFS_SB_FEAT_INCOMPAT_NEEDSREPAIR);
> 4a9bca86806fa6 Darrick J. Wong     2022-01-07  308              if ((cpu_to_be32(mp->m_sb.sb_features_incompat) ^
> 4a9bca86806fa6 Darrick J. Wong     2022-01-07  309                              sb->sb_features_incompat) & features_mask)
> 4a9bca86806fa6 Darrick J. Wong     2022-01-07  310                      xchk_block_set_preen(sc, bp);
> 4a9bca86806fa6 Darrick J. Wong     2022-01-07  311
> 4a9bca86806fa6 Darrick J. Wong     2022-01-07  312              /* all other incompat features must match */
> 4a9bca86806fa6 Darrick J. Wong     2022-01-07  313              if ((cpu_to_be32(mp->m_sb.sb_features_incompat) ^
> 4a9bca86806fa6 Darrick J. Wong     2022-01-07  314                              sb->sb_features_incompat) & ~features_mask)
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  315                      xchk_block_set_corrupt(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  316
> 4a9bca86806fa6 Darrick J. Wong     2022-01-07  317              /*
> 4a9bca86806fa6 Darrick J. Wong     2022-01-07  318               * log incompat features protect newer log record types from
> 4a9bca86806fa6 Darrick J. Wong     2022-01-07  319               * older log recovery code.  Log recovery doesn't check the
> 4a9bca86806fa6 Darrick J. Wong     2022-01-07  320               * secondary supers, so we can clear these if needed.
> 4a9bca86806fa6 Darrick J. Wong     2022-01-07  321               */
> 4a9bca86806fa6 Darrick J. Wong     2022-01-07  322              if (sb->sb_features_log_incompat)
> 4a9bca86806fa6 Darrick J. Wong     2022-01-07  323                      xchk_block_set_preen(sc, bp);
> 4a9bca86806fa6 Darrick J. Wong     2022-01-07  324
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  325              /* Don't care about sb_crc */
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  326
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  327              if (sb->sb_spino_align != cpu_to_be32(mp->m_sb.sb_spino_align))
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  328                      xchk_block_set_corrupt(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  329
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  330              if (sb->sb_pquotino != cpu_to_be64(mp->m_sb.sb_pquotino))
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  331                      xchk_block_set_preen(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  332
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  333              /* Don't care about sb_lsn */
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  334      }
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  335
> 38c26bfd90e199 Dave Chinner        2021-08-18  336      if (xfs_has_metauuid(mp)) {
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  337              /* The metadata UUID must be the same for all supers */
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  338              if (!uuid_equal(&sb->sb_meta_uuid, &mp->m_sb.sb_meta_uuid))
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  339                      xchk_block_set_corrupt(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  340      }
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  341
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  342      /* Everything else must be zero. */
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  343      if (memchr_inv(sb + 1, 0,
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  344                      BBTOB(bp->b_length) - sizeof(struct xfs_dsb)))
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  345              xchk_block_set_corrupt(sc, bp);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  346
> c517b3aa02cff1 Darrick J. Wong     2018-07-19  347      xchk_superblock_xref(sc, bp);
> 48c6615cc55759 Darrick J. Wong     2021-08-06  348  out_pag:
> 48c6615cc55759 Darrick J. Wong     2021-08-06  349      xfs_perag_put(pag);
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  350      return error;
> 21fb4cb1981ef7 Darrick J. Wong     2017-10-17  351  }
> ab9d5dc59fe615 Darrick J. Wong     2017-10-17  352
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C8C48A05F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 20:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243992AbiAJToa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 14:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243901AbiAJTo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 14:44:27 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539D8C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 11:44:27 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id g26so48240020lfv.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 11:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jtQw4y0XUSAe0KrKew4948HjIuN33SOg3PoHTbQjNow=;
        b=dpgMXiG4rLfyifvMNiiPSyBthCp+BPqr76Ku1uiRrokwlBWpPPcRUrD5utNZ41dykL
         zmCtNO5k212skBq1Egh3/xYKV+WZC7Hb6UxjlpcQ5BmgyxljgXk3zFHlCG714dYwWKC+
         xkDYVeSGBU4nsYtrGRu6bxW/a+HEIg7mpV02LzaG8mGyJYcU6z6N12MoXAGK41GO0Ong
         kZ7cyG1hDddumh5xh5qus3qdbFu3m4lp81Hr5pCHNibmGSeJkQ1ymHt1uqDZSDg40rsI
         vQW/KMFf0MLfzaVXr5OgpaZis4nFNCGoFWi0qmhFVClP0bt8E/XJdqk7a99ymIIhJDpb
         KayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jtQw4y0XUSAe0KrKew4948HjIuN33SOg3PoHTbQjNow=;
        b=JpttC938dfFQhGo3qFfZLTD33uRJRA/+NUouiYm+/9PMr5RRgiLZW7Z+6XutKxePKP
         H/cUe0dLrHRHVC9brC+GrJapXMm3z82waYajN451W9kuydoCsgR+jAq4SGhbtlFvuA+3
         VchQHNPPfU1u/ht8BM94IU5yZII9bQPNS1dtHc+hagcmx63/INhcko4ibpZ8taTzNVtz
         lXSF5rZ/1UHsY+VF7rtWGWkx9FRKmBb9kfAAO/8ddz744TN+sLKlrpexGxtdnIFa01aq
         3uzADT00IL4PCJJFCt+zUEFLQdt3DaoEt8gvFVH5Lq79WHv7nNjhU9hQFitXPtx9TDE4
         GW1g==
X-Gm-Message-State: AOAM530uiPMxKqcaVtEESiafxJWW4xnkYe8sSTD262nTTOMCf4IbGf94
        7G8wWk5fU1VFKhB5TRsRYrevz9Pk+yuNOhL3SFa5sw==
X-Google-Smtp-Source: ABdhPJzKt6Tm6QbXWqsJmiL7atRQtt6k3qJ11s2E1d18aG9vCMkZyL5yIW3vQUI8yfuC3FcXWnpCh2lTYobvZC/ZFm0=
X-Received: by 2002:a05:6512:3baa:: with SMTP id g42mr886997lfv.651.1641843865360;
 Mon, 10 Jan 2022 11:44:25 -0800 (PST)
MIME-Version: 1.0
References: <202201081852.uTfBqS4b-lkp@intel.com> <CAHp75VfS-4B1AwzawCR7VVAxopK6ACcY63ig07OqY32MswfoOQ@mail.gmail.com>
In-Reply-To: <CAHp75VfS-4B1AwzawCR7VVAxopK6ACcY63ig07OqY32MswfoOQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 10 Jan 2022 11:44:12 -0800
Message-ID: <CAKwvOdk9XFOL2RAh5+FKWMR9jWFwrS=J+ogwUPj5OOLXcr-iSQ@mail.gmail.com>
Subject: Re: drivers/media/v4l2-core/v4l2-ioctl.c:303:28: warning: taking
 address of packed member 'pixelformat' of class or structure
 'v4l2_pix_format_mplane' may result in an unaligned pointer value
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Roman Lebedev <lebedev.ri@gmail.com>,
        Richard Smith <richard@metafoo.co.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 9, 2022 at 6:26 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> +Nick Desaulniers
>
> Any ideas on how to fix this?

Not obviously.  This code probably will trigger a splat when run with
UBSan though.

I'm curious if the structure needs to be packed for interfacing with
hardware or some ABI, or whether we could add an explicit alignment to
the member if that would be ok (which may add back some padding)?
Otherwise, I suspect to actually access this properly we may have
macros for performing underaligned loads and stores?  I suspect you'd
read potentially unaligned data into an aligned copy, then do
operations on that, at which point printing the address of the copy is
legal, but perhaps useless.

Perhaps:

diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index df8b9c486ba1..3bb8d7aaba8a 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -2293,7 +2293,7 @@ struct v4l2_plane_pix_format {
 struct v4l2_pix_format_mplane {
        __u32                           width;
        __u32                           height;
-       __u32                           pixelformat;
+       __u32                           pixelformat __aligned(4);
        __u32                           field;
        __u32                           colorspace;

Perhaps we could tighten up this warning in clang; we don't have any
holes before this member, so I _wouldn't_ have assumed
__attribute__((packed)) would have caused the address of pixelformat
member of an instance of struct v4l2_pix_format_mplane to ever be
underaligned.

>
>
> On Sun, Jan 9, 2022 at 3:53 PM kernel test robot <lkp@intel.com> wrote:
> >
> > Hi Sakari,
> >
> > FYI, the error/warning still remains.
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   d1587f7bfe9a0f97a75d42ac1489aeda551106bc
> > commit: e927e1e0f0dd3e353d5556503a71484008692c82 v4l: ioctl: Use %p4cc printk modifier to print FourCC codes
> > date:   11 months ago
> > config: mips-buildonly-randconfig-r002-20220107 (https://download.01.org/0day-ci/archive/20220108/202201081852.uTfBqS4b-lkp@intel.com/config)
> > compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 32167bfe64a4c5dd4eb3f7a58e24f4cba76f5ac2)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install mips cross compiling tool for clang build
> >         # apt-get install binutils-mips-linux-gnu
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e927e1e0f0dd3e353d5556503a71484008692c82
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout e927e1e0f0dd3e353d5556503a71484008692c82
> >         # save the config file to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/hid/ drivers/media/v4l2-core/ fs/
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> > >> drivers/media/v4l2-core/v4l2-ioctl.c:303:28: warning: taking address of packed member 'pixelformat' of class or structure 'v4l2_pix_format_mplane' may result in an unaligned pointer value [-Waddress-of-packed-member]
> >                            mp->width, mp->height, &mp->pixelformat,
> >                                                    ^~~~~~~~~~~~~~~
> >    include/linux/printk.h:385:26: note: expanded from macro 'pr_cont'
> >            printk(KERN_CONT fmt, ##__VA_ARGS__)
> >                                    ^~~~~~~~~~~
> > >> drivers/media/v4l2-core/v4l2-ioctl.c:347:37: warning: taking address of packed member 'pixelformat' of class or structure 'v4l2_sdr_format' may result in an unaligned pointer value [-Waddress-of-packed-member]
> >                    pr_cont(", pixelformat=%p4cc\n", &sdr->pixelformat);
> >                                                      ^~~~~~~~~~~~~~~~
> >    include/linux/printk.h:385:26: note: expanded from macro 'pr_cont'
> >            printk(KERN_CONT fmt, ##__VA_ARGS__)
> >                                    ^~~~~~~~~~~
> > >> drivers/media/v4l2-core/v4l2-ioctl.c:353:5: warning: taking address of packed member 'dataformat' of class or structure 'v4l2_meta_format' may result in an unaligned pointer value [-Waddress-of-packed-member]
> >                            &meta->dataformat, meta->buffersize);
> >                             ^~~~~~~~~~~~~~~~
> >    include/linux/printk.h:385:26: note: expanded from macro 'pr_cont'
> >            printk(KERN_CONT fmt, ##__VA_ARGS__)
> >                                    ^~~~~~~~~~~
> >    3 warnings generated.
> >
> >
> > vim +303 drivers/media/v4l2-core/v4l2-ioctl.c
> >
> >    273
> >    274  static void v4l_print_format(const void *arg, bool write_only)
> >    275  {
> >    276          const struct v4l2_format *p = arg;
> >    277          const struct v4l2_pix_format *pix;
> >    278          const struct v4l2_pix_format_mplane *mp;
> >    279          const struct v4l2_vbi_format *vbi;
> >    280          const struct v4l2_sliced_vbi_format *sliced;
> >    281          const struct v4l2_window *win;
> >    282          const struct v4l2_sdr_format *sdr;
> >    283          const struct v4l2_meta_format *meta;
> >    284          u32 planes;
> >    285          unsigned i;
> >    286
> >    287          pr_cont("type=%s", prt_names(p->type, v4l2_type_names));
> >    288          switch (p->type) {
> >    289          case V4L2_BUF_TYPE_VIDEO_CAPTURE:
> >    290          case V4L2_BUF_TYPE_VIDEO_OUTPUT:
> >    291                  pix = &p->fmt.pix;
> >    292                  pr_cont(", width=%u, height=%u, pixelformat=%p4cc, field=%s, bytesperline=%u, sizeimage=%u, colorspace=%d, flags=0x%x, ycbcr_enc=%u, quantization=%u, xfer_func=%u\n",
> >    293                          pix->width, pix->height, &pix->pixelformat,
> >    294                          prt_names(pix->field, v4l2_field_names),
> >    295                          pix->bytesperline, pix->sizeimage,
> >    296                          pix->colorspace, pix->flags, pix->ycbcr_enc,
> >    297                          pix->quantization, pix->xfer_func);
> >    298                  break;
> >    299          case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
> >    300          case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
> >    301                  mp = &p->fmt.pix_mp;
> >    302                  pr_cont(", width=%u, height=%u, format=%p4cc, field=%s, colorspace=%d, num_planes=%u, flags=0x%x, ycbcr_enc=%u, quantization=%u, xfer_func=%u\n",
> >  > 303                          mp->width, mp->height, &mp->pixelformat,
> >    304                          prt_names(mp->field, v4l2_field_names),
> >    305                          mp->colorspace, mp->num_planes, mp->flags,
> >    306                          mp->ycbcr_enc, mp->quantization, mp->xfer_func);
> >    307                  planes = min_t(u32, mp->num_planes, VIDEO_MAX_PLANES);
> >    308                  for (i = 0; i < planes; i++)
> >    309                          printk(KERN_DEBUG "plane %u: bytesperline=%u sizeimage=%u\n", i,
> >    310                                          mp->plane_fmt[i].bytesperline,
> >    311                                          mp->plane_fmt[i].sizeimage);
> >    312                  break;
> >    313          case V4L2_BUF_TYPE_VIDEO_OVERLAY:
> >    314          case V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY:
> >    315                  win = &p->fmt.win;
> >    316                  /* Note: we can't print the clip list here since the clips
> >    317                   * pointer is a userspace pointer, not a kernelspace
> >    318                   * pointer. */
> >    319                  pr_cont(", wxh=%dx%d, x,y=%d,%d, field=%s, chromakey=0x%08x, clipcount=%u, clips=%p, bitmap=%p, global_alpha=0x%02x\n",
> >    320                          win->w.width, win->w.height, win->w.left, win->w.top,
> >    321                          prt_names(win->field, v4l2_field_names),
> >    322                          win->chromakey, win->clipcount, win->clips,
> >    323                          win->bitmap, win->global_alpha);
> >    324                  break;
> >    325          case V4L2_BUF_TYPE_VBI_CAPTURE:
> >    326          case V4L2_BUF_TYPE_VBI_OUTPUT:
> >    327                  vbi = &p->fmt.vbi;
> >    328                  pr_cont(", sampling_rate=%u, offset=%u, samples_per_line=%u, sample_format=%p4cc, start=%u,%u, count=%u,%u\n",
> >    329                          vbi->sampling_rate, vbi->offset,
> >    330                          vbi->samples_per_line, &vbi->sample_format,
> >    331                          vbi->start[0], vbi->start[1],
> >    332                          vbi->count[0], vbi->count[1]);
> >    333                  break;
> >    334          case V4L2_BUF_TYPE_SLICED_VBI_CAPTURE:
> >    335          case V4L2_BUF_TYPE_SLICED_VBI_OUTPUT:
> >    336                  sliced = &p->fmt.sliced;
> >    337                  pr_cont(", service_set=0x%08x, io_size=%d\n",
> >    338                                  sliced->service_set, sliced->io_size);
> >    339                  for (i = 0; i < 24; i++)
> >    340                          printk(KERN_DEBUG "line[%02u]=0x%04x, 0x%04x\n", i,
> >    341                                  sliced->service_lines[0][i],
> >    342                                  sliced->service_lines[1][i]);
> >    343                  break;
> >    344          case V4L2_BUF_TYPE_SDR_CAPTURE:
> >    345          case V4L2_BUF_TYPE_SDR_OUTPUT:
> >    346                  sdr = &p->fmt.sdr;
> >  > 347                  pr_cont(", pixelformat=%p4cc\n", &sdr->pixelformat);
> >    348                  break;
> >    349          case V4L2_BUF_TYPE_META_CAPTURE:
> >    350          case V4L2_BUF_TYPE_META_OUTPUT:
> >    351                  meta = &p->fmt.meta;
> >    352                  pr_cont(", dataformat=%p4cc, buffersize=%u\n",
> >  > 353                          &meta->dataformat, meta->buffersize);
> >    354                  break;
> >    355          }
> >    356  }
> >    357
> >
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>
>
>
> --
> With Best Regards,
> Andy Shevchenko
>


-- 
Thanks,
~Nick Desaulniers

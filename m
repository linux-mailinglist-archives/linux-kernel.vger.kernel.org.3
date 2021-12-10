Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D090C470BD5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 21:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344168AbhLJUdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 15:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344099AbhLJUdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 15:33:39 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A381C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 12:30:04 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id i63so15398752lji.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 12:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q5IDfWTD4HswiA3xg7kJjyFFAc89Uqs7l/rD/15px58=;
        b=OcRjcFC1ehGIzj5CzUBWWcIRBVtQkNQOWCWfdY+oVIDO17sShGHkR0QOshLkVLVH7B
         ahF14TP58RnZ0+Iw2X0LhrD3VYgT+4f/OAWqmR/36mR3QlShE13m5Dxcmm189OGxlgG7
         zPPRpUciUxUOjL8r5v1bAeD0NoCpswOUfc85a89w+wd9waxGSHjc7SIgnmMcd8Q3sHHc
         gVsdVMK7mIUpVsD7vfyXlqzplP86RKfImWnCWE1nowg8rDP5M9iiFNWMsxfE0Q00gaFv
         idwJgeFm5kC0H4/NnmYFDwDX9AErEsxkT9LV7fTNJlok9dIPTbBQmxz49UK85lodDYAq
         +raA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q5IDfWTD4HswiA3xg7kJjyFFAc89Uqs7l/rD/15px58=;
        b=XLg9ffdA6I3EM8dWv327AD01GglIf3mvz+2on4jT8pOPyikORt1S30br2DYZS58bth
         OAE88pHGIvVdpZ3IVUXKzomptkHSe/mQDkCpKGToEp03s5uHed+2VzeE+XeyCzUD9pYo
         r0RyNiUaUTQsc1+/V/4x99BeCVf1bmfYlorSY+bMPYUcYwIa6OIKJ7g26IPkmJK0U4l6
         QxdqyUj2imx8D+PWSn5oe+jvXaVXK2N6scCr55F1FW+3UANz+ykHSHSBa/IKOWUPI0Ft
         H/VREUcOrTTBwtG98gfWE4bwSFEBnLw0Q5//RxZNHHYJZG0hI+A0AdBdtu6fqIBnO2h7
         +3bg==
X-Gm-Message-State: AOAM532/FYdpfz1SJgeJT18Nr74z6+Ub96isQGlcU8pzKR8qv2h5hiHy
        w/ERVI5sniyXgXSNehd9d9flvA/Wvs7cE7EbCjs0eA==
X-Google-Smtp-Source: ABdhPJwk/r6oh8GE8DbqSJjW/LqbWXoNi4I2ExIi4MvjoJM3Klp4paXKaKbYOO6DD+XPMjRshlD2f0PH5XxSYI29L9M=
X-Received: by 2002:a2e:9197:: with SMTP id f23mr14907477ljg.235.1639168201764;
 Fri, 10 Dec 2021 12:30:01 -0800 (PST)
MIME-Version: 1.0
References: <20211210053743.GA36420@xsang-OptiPlex-9020> <CAHk-=wgxd2DqzM3PAsFmzJDHFggxg7ODTQxfJoGCRDbjgMm8nA@mail.gmail.com>
In-Reply-To: <CAHk-=wgxd2DqzM3PAsFmzJDHFggxg7ODTQxfJoGCRDbjgMm8nA@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 10 Dec 2021 21:29:35 +0100
Message-ID: <CAG48ez1pnatAB095dnbrn9LbuQe4+ENwh-WEW36pM40ozhpruw@mail.gmail.com>
Subject: Re: [fget] 054aa8d439: will-it-scale.per_thread_ops -5.7% regression
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 On Fri, Dec 10, 2021 at 7:34 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Dec 9, 2021 at 9:38 PM kernel test robot <oliver.sang@intel.com> =
wrote:
> >
> > FYI, we noticed a -5.7% regression of will-it-scale.per_thread_ops due =
to commit:
> > 054aa8d439b9  ("fget: check that the fd still exists after getting a re=
f to it")
>
> Well, some downside of the new checks was expected, that's just much
> more than I really like or would have thought.
>
> But it's exactly where you'd expect:
>
> >      27.16 =C2=B1 10%      +4.3       31.51 =C2=B1  2%  perf-profile.ca=
lltrace.cycles-pp.__fget_light.do_sys_poll.__x64_sys_poll.do_syscall_64.ent=
ry_SYSCALL_64_after_hwframe
> >      22.91 =C2=B1 10%      +4.4       27.34 =C2=B1  2%  perf-profile.ca=
lltrace.cycles-pp.__fget_files.__fget_light.do_sys_poll.__x64_sys_poll.do_s=
yscall_64
> >      26.33 =C2=B1 10%      +4.4       30.70 =C2=B1  2%  perf-profile.ch=
ildren.cycles-pp.__fget_light
> >      22.92 =C2=B1 10%      +4.4       27.35 =C2=B1  2%  perf-profile.ch=
ildren.cycles-pp.__fget_files
> >      22.70 =C2=B1 10%      +4.4       27.11 =C2=B1  2%  perf-profile.se=
lf.cycles-pp.__fget_files
>
> although there's odd spikes in dTLB-loads etc.
>
> I checked whether it's some unexpected code generation issue, but the
> new "re-check file table after refcount update" really looks very
> cheap when I look at what gcc generates, there's nothing really
> unexpected there.
>
> What did change was:
>
>  (a) some branches go other ways, which might well affect branch
> prediction and just be unlucky. It might be that just marking the
> mismatch case "unlikely()" will help.
>
>  (b) the obvious few new instructions (re-load and check file table
> pointer, re-load and check file pointer)
>
>  (c) that __fget_files() function is now no longer a leaf function in
> a simple config case, since it calls "fput_many" in the error case.
>
> And that (c) is worth mentioning simply because it means that the
> function goes from not having any stack frame at all, to having to
> save/restore four registers. So now it has the usual push/pop
> sequences.
>
> It may also be that the test-case actually does a lot of threaded
> open/close/poll, and either actually triggers the re-lookup looping
> case (unlikely) or just sees a lot of cacheline bouncing that now got
> worse due to the re-check of the file pointer.
>
> So this regression looks real, and the issue seems to be that
> __fget_files() really is _that_ important for this do_sys_poll()
> benchmark, and even just the handful of extra instructions end up
> being meaningful.
>
> Oliver - I'm attaching the obvious "unlikely9)" oneliner in case it's
> just "gcc thought the retry loop was the common case" issue and bad
> branch prediction.
>
> And it would perhaps be interesting to get an actual instruction-level
> profile of that __fget_files() thing for that benchmark, if that
> pinpoints exactly what is going on and in case that would be easy to
> get on that machine.
>
> Because it might just be truly horrendously bad luck, with the 32-byte
> stack frame meaning that the kernel stack goes one more page down
> (just jhandwaving from the dTLB number spike), and this all being just
> random bad luck on that particular benchmark.
>
> Of course, the thing about poll() is that for that case, we *don't*
> really need the "re-check the file descriptor" code at all, since the
> resulting fd isn't going to be installed as a new fd, and it doesn't
> matter for the socket garbage collector logic.
>
> So maybe it was a mistake to put that re-check in the generic fdget()
> code - yes, it should be cheap, but it's also some of the most hot
> code in the kernel on some loads.
>
> But if we move it elsewhere, we'd need to come up with some list of
> "these cases need it". Some are obvious: dup, dup2, unix domain file
> passing. It's the non-obvious ones I'd worry about.

The thing is, even though my proof of concept used dup() to put the
file in the fd table again, that's not strictly necessary. Instead of
using dup() for the race, you could also use recvmsg() directly with
the right timing.

And the recvmsg() path is wired up to a ton of syscalls, including
read(), I believe? So you'd have to special-case read(), readv(),
recv(), recvmsg(), io_submit(), splice(), the io_uring stuff, and so
on. And I think read() is probably one of the hottest syscalls related
to file I/O?


Oh, and I just realized that your patch probably actually also fixes
an issue entirely unrelated to unix sockets. __fdget_pos() does this:

unsigned long __fdget_pos(unsigned int fd)
{
  unsigned long v =3D __fdget(fd);
  struct file *file =3D (struct file *)(v & ~3);

  if (file && (file->f_mode & FMODE_ATOMIC_POS)) {
    if (file_count(file) > 1) {
      v |=3D FDPUT_POS_UNLOCK;
      mutex_lock(&file->f_pos_lock);
    }
  }
  return v;
}

and with the same fget race, I think you could get past that
file_count(file) check?

FMODE_ATOMIC_POS is always set for regular files and directories,
which means that this is what protects getdents()'s access to the file
offset when it calls into f_op->iterate_shared():

SYSCALL_DEFINE3(getdents, unsigned int, fd,
struct linux_dirent __user *, dirent, unsigned int, count)
{
  struct fd f;
[...]
  f =3D fdget_pos(fd);
  if (!f.file)
    return -EBADF;

  error =3D iterate_dir(f.file, &buf.ctx);
  if (error >=3D 0)
    error =3D buf.error;
[...]
  fdput_pos(f);
  return error;
}

int iterate_dir(struct file *file, struct dir_context *ctx)
{
  struct inode *inode =3D file_inode(file);
  bool shared =3D false;
  int res =3D -ENOTDIR;
  if (file->f_op->iterate_shared)
    shared =3D true;
  else if (!file->f_op->iterate)
    goto out;
[...]
  if (shared)
    res =3D down_read_killable(&inode->i_rwsem);
  else
    [...]
  if (res)
    goto out;
[...]
  if (!IS_DEADDIR(inode)) {
    ctx->pos =3D file->f_pos;
    if (shared)
      res =3D file->f_op->iterate_shared(file, ctx);
    else
      res =3D file->f_op->iterate(file, ctx);
    file->f_pos =3D ctx->pos;
[...]
  }
  if (shared)
    inode_unlock_shared(inode);
  else
    [...]
out:
return res;
}

And the ext4 implementation of ->iterate_shared(), which doesn't seem
to be taking any exclusive locks, then also reads and writes
->f_version and relies on having that in sync with ->f_pos. (At least
in the inline storage case it looks that way, I haven't looked at the
rest.) So I think that without your fix, it might also be possible to
get ext4 to read a struct ext4_dir_entry_2 from a misaligned offset? I
don't think that would lead to memory corruption, just to getting
bogus data from getdents() and/or making ext4 think that the
filesystem is corrupted, but it's not exactly great...

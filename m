Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333FF494FBC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 15:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245443AbiATOBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 09:01:30 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:47998 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244837AbiATOB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 09:01:28 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4ADBA1F3AA;
        Thu, 20 Jan 2022 14:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642687287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q517tTr/OE7+FoaZ4PZQ3o74fISYYqKhdrrzJPqaSQQ=;
        b=uM7q3qTxQ7p4QrOXIJDqYls0Zt1hb2zDc36VDlSMFrRy6PhK6lNN9CyRIZcK9EyQZlS9hL
        e5ALY10l7aDXyaW4Q0UMX3eW9wKgItXbucy0W0Zjc4Hm32mmuALOd2OQiIM53kkHpyazHu
        hGhzMUtkrRVDxR5D2i2OCXILBxyABNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642687287;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q517tTr/OE7+FoaZ4PZQ3o74fISYYqKhdrrzJPqaSQQ=;
        b=MCIQBGHaDTkl0bR7Skcjq7aBnAqega56KbTNGP7MXskdWP+fJ4YRx7myX4C4XK2Ix0o5kO
        VGOnC919zDVVVOAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2675113EA6;
        Thu, 20 Jan 2022 14:01:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LxaeCTdr6WHRDgAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 20 Jan 2022 14:01:27 +0000
Date:   Thu, 20 Jan 2022 15:01:26 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/2] block: hold queue lock while iterating in
 diskstats_show
Message-ID: <20220120140126.ntzvrcmczd7pph75@carbon.lan>
References: <20220120105248.117025-1-dwagner@suse.de>
 <20220120105248.117025-3-dwagner@suse.de>
 <Yelb4+r5KuV67tO0@T590>
 <20220120131936.mlug7nhnoe73abx5@carbon.lan>
 <Yelo1gx5cp1l4npK@T590>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="z5lccj23sq3wwiaf"
Content-Disposition: inline
In-Reply-To: <Yelo1gx5cp1l4npK@T590>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z5lccj23sq3wwiaf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 20, 2022 at 09:51:18PM +0800, Ming Lei wrote:
> Then Can you figure out where blk_mq_queue_tag_busy_iter+0x1e4 points to
> in source code? And what is NULL pointer?

Here we go:

/usr/src/debug/kernel-default-5.3.18-59.27.1.x86_64/linux-5.3/linux-obj/../include/linux/sbitmap.h: 249
0xffffffffb244a254 <blk_mq_queue_tag_busy_iter+484>:    mov    (%rax),%rdx

234static inline void __sbitmap_for_each_set(struct sbitmap *sb,
235                                          unsigned int start,
236                                          sb_for_each_fn fn, void *data)
237{
238        unsigned int index;
239        unsigned int nr;
240        unsigned int scanned = 0;
241
242        if (start >= sb->depth)
243                start = 0;
244        index = SB_NR_TO_INDEX(sb, start);
245        nr = SB_NR_TO_BIT(sb, start);
246
247        while (scanned < sb->depth) {
248                unsigned long word;
249                unsigned int depth = min_t(unsigned int,
250                                           sb->map[index].depth - nr,
251                                           sb->depth - scanned);


--z5lccj23sq3wwiaf
Content-Type: application/vnd.mobius.dis
Content-Disposition: attachment; filename="blk_mq_queue_tag_busy_iter.dis"
Content-Transfer-Encoding: quoted-printable

0xffffffffbaa4a070 <blk_mq_queue_tag_busy_iter>:	nopl   0x0(%rax,%rax,1) [F=
TRACE NOP]=0A0xffffffffbaa4a075 <blk_mq_queue_tag_busy_iter+5>:	push   %r15=
=0A0xffffffffbaa4a077 <blk_mq_queue_tag_busy_iter+7>:	push   %r14=0A0xfffff=
fffbaa4a079 <blk_mq_queue_tag_busy_iter+9>:	push   %r13=0A0xffffffffbaa4a07=
b <blk_mq_queue_tag_busy_iter+11>:	push   %r12=0A0xffffffffbaa4a07d <blk_mq=
_queue_tag_busy_iter+13>:	push   %rbp=0A0xffffffffbaa4a07e <blk_mq_queue_ta=
g_busy_iter+14>:	push   %rbx=0A0xffffffffbaa4a07f <blk_mq_queue_tag_busy_it=
er+15>:	sub    $0x60,%rsp=0A0xffffffffbaa4a083 <blk_mq_queue_tag_busy_iter+=
19>:	mov    %rdi,0x8(%rsp)=0A0xffffffffbaa4a088 <blk_mq_queue_tag_busy_iter=
+24>:	mov    %rsi,0x10(%rsp)=0A0xffffffffbaa4a08d <blk_mq_queue_tag_busy_it=
er+29>:	mov    %rdx,0x18(%rsp)=0A0xffffffffbaa4a092 <blk_mq_queue_tag_busy_=
iter+34>:	mov    %gs:0x28,%rcx=0A0xffffffffbaa4a09b <blk_mq_queue_tag_busy_=
iter+43>:	mov    %rcx,0x58(%rsp)=0A0xffffffffbaa4a0a0 <blk_mq_queue_tag_bus=
y_iter+48>:	xor    %ecx,%ecx=0A0xffffffffbaa4a0a2 <blk_mq_queue_tag_busy_it=
er+50>:	mov    0x600(%rdi),%rax=0A0xffffffffbaa4a0a9 <blk_mq_queue_tag_busy=
_iter+57>:	test   $0x3,%al=0A0xffffffffbaa4a0ab <blk_mq_queue_tag_busy_iter=
+59>:	jne    0xffffffffbaa4a2ea <blk_mq_queue_tag_busy_iter+634>=0A0xffffff=
ffbaa4a0b1 <blk_mq_queue_tag_busy_iter+65>:	incq   %gs:(%rax)=0A0xffffffffb=
aa4a0b5 <blk_mq_queue_tag_busy_iter+69>:	mov    0x8(%rsp),%rax=0A0xffffffff=
baa4a0ba <blk_mq_queue_tag_busy_iter+74>:	movl   $0x0,0x4(%rsp)=0A0xfffffff=
fbaa4a0c2 <blk_mq_queue_tag_busy_iter+82>:	mov    0x40(%rax),%edx=0A0xfffff=
fffbaa4a0c5 <blk_mq_queue_tag_busy_iter+85>:	test   %edx,%edx=0A0xffffffffb=
aa4a0c7 <blk_mq_queue_tag_busy_iter+87>:	je     0xffffffffbaa4a19a <blk_mq_=
queue_tag_busy_iter+298>=0A0xffffffffbaa4a0cd <blk_mq_queue_tag_busy_iter+9=
3>:	mov    0x8(%rsp),%rdi=0A0xffffffffbaa4a0d2 <blk_mq_queue_tag_busy_iter+=
98>:	movslq 0x4(%rsp),%rax=0A0xffffffffbaa4a0d7 <blk_mq_queue_tag_busy_iter=
+103>:	mov    0x38(%rdi),%rdx=0A0xffffffffbaa4a0db <blk_mq_queue_tag_busy_i=
ter+107>:	mov    (%rdx,%rax,8),%r13=0A0xffffffffbaa4a0df <blk_mq_queue_tag_=
busy_iter+111>:	cmpw   $0x0,0xf6(%r13)=0A0xffffffffbaa4a0e8 <blk_mq_queue_t=
ag_busy_iter+120>:	mov    0x138(%r13),%r14=0A0xffffffffbaa4a0ef <blk_mq_que=
ue_tag_busy_iter+127>:	je     0xffffffffbaa4a183 <blk_mq_queue_tag_busy_ite=
r+275>=0A0xffffffffbaa4a0f5 <blk_mq_queue_tag_busy_iter+133>:	test   %r14,%=
r14=0A0xffffffffbaa4a0f8 <blk_mq_queue_tag_busy_iter+136>:	je     0xfffffff=
fbaa4a183 <blk_mq_queue_tag_busy_iter+275>=0A0xffffffffbaa4a0fe <blk_mq_que=
ue_tag_busy_iter+142>:	mov    0x4(%r14),%eax=0A0xffffffffbaa4a102 <blk_mq_q=
ueue_tag_busy_iter+146>:	test   %eax,%eax=0A0xffffffffbaa4a104 <blk_mq_queu=
e_tag_busy_iter+148>:	jne    0xffffffffbaa4a207 <blk_mq_queue_tag_busy_iter=
+407>=0A0xffffffffbaa4a10a <blk_mq_queue_tag_busy_iter+154>:	mov    0x10(%r=
sp),%rax=0A0xffffffffbaa4a10f <blk_mq_queue_tag_busy_iter+159>:	mov    0x10=
(%r14),%r15=0A0xffffffffbaa4a113 <blk_mq_queue_tag_busy_iter+163>:	xor    %=
ebp,%ebp=0A0xffffffffbaa4a115 <blk_mq_queue_tag_busy_iter+165>:	mov    %r13=
,0x38(%rsp)=0A0xffffffffbaa4a11a <blk_mq_queue_tag_busy_iter+170>:	movb   $=
0x0,0x50(%rsp)=0A0xffffffffbaa4a11f <blk_mq_queue_tag_busy_iter+175>:	xor  =
  %r13d,%r13d=0A0xffffffffbaa4a122 <blk_mq_queue_tag_busy_iter+178>:	mov   =
 %rax,0x40(%rsp)=0A0xffffffffbaa4a127 <blk_mq_queue_tag_busy_iter+183>:	mov=
    0x18(%rsp),%rax=0A0xffffffffbaa4a12c <blk_mq_queue_tag_busy_iter+188>:	=
mov    %rax,0x48(%rsp)=0A0xffffffffbaa4a131 <blk_mq_queue_tag_busy_iter+193=
>:	mov    (%r15),%ebx=0A0xffffffffbaa4a134 <blk_mq_queue_tag_busy_iter+196>=
:	test   %ebx,%ebx=0A0xffffffffbaa4a136 <blk_mq_queue_tag_busy_iter+198>:	j=
e     0xffffffffbaa4a183 <blk_mq_queue_tag_busy_iter+275>=0A0xffffffffbaa4a=
138 <blk_mq_queue_tag_busy_iter+200>:	mov    %ebp,%eax=0A0xffffffffbaa4a13a=
 <blk_mq_queue_tag_busy_iter+202>:	sub    %r13d,%ebx=0A0xffffffffbaa4a13d <=
blk_mq_queue_tag_busy_iter+205>:	lea    (%rax,%rax,2),%rax=0A0xffffffffbaa4=
a141 <blk_mq_queue_tag_busy_iter+209>:	shl    $0x6,%rax=0A0xffffffffbaa4a14=
5 <blk_mq_queue_tag_busy_iter+213>:	add    0x10(%r15),%rax=0A0xffffffffbaa4=
a149 <blk_mq_queue_tag_busy_iter+217>:	mov    (%rax),%rdx=0A0xffffffffbaa4a=
14c <blk_mq_queue_tag_busy_iter+220>:	cmp    %edx,%ebx=0A0xffffffffbaa4a14e=
 <blk_mq_queue_tag_busy_iter+222>:	cmovae %edx,%ebx=0A0xffffffffbaa4a151 <b=
lk_mq_queue_tag_busy_iter+225>:	mov    0x80(%rax),%rdx=0A0xffffffffbaa4a158=
 <blk_mq_queue_tag_busy_iter+232>:	add    %ebx,%r13d=0A0xffffffffbaa4a15b <=
blk_mq_queue_tag_busy_iter+235>:	not    %rdx=0A0xffffffffbaa4a15e <blk_mq_q=
ueue_tag_busy_iter+238>:	and    0x40(%rax),%rdx=0A0xffffffffbaa4a162 <blk_m=
q_queue_tag_busy_iter+242>:	test   %rdx,%rdx=0A0xffffffffbaa4a165 <blk_mq_q=
ueue_tag_busy_iter+245>:	mov    %rdx,0x30(%rsp)=0A0xffffffffbaa4a16a <blk_m=
q_queue_tag_busy_iter+250>:	jne    0xffffffffbaa4a1c7 <blk_mq_queue_tag_bus=
y_iter+343>=0A0xffffffffbaa4a16c <blk_mq_queue_tag_busy_iter+252>:	add    $=
0x1,%ebp=0A0xffffffffbaa4a16f <blk_mq_queue_tag_busy_iter+255>:	cmp    0x8(=
%r15),%ebp=0A0xffffffffbaa4a173 <blk_mq_queue_tag_busy_iter+259>:	mov    (%=
r15),%ebx=0A0xffffffffbaa4a176 <blk_mq_queue_tag_busy_iter+262>:	mov    $0x=
0,%eax=0A0xffffffffbaa4a17b <blk_mq_queue_tag_busy_iter+267>:	cmovae %eax,%=
ebp=0A0xffffffffbaa4a17e <blk_mq_queue_tag_busy_iter+270>:	cmp    %r13d,%eb=
x=0A0xffffffffbaa4a181 <blk_mq_queue_tag_busy_iter+273>:	ja     0xffffffffb=
aa4a138 <blk_mq_queue_tag_busy_iter+200>=0A0xffffffffbaa4a183 <blk_mq_queue=
_tag_busy_iter+275>:	mov    0x8(%rsp),%rcx=0A0xffffffffbaa4a188 <blk_mq_que=
ue_tag_busy_iter+280>:	addl   $0x1,0x4(%rsp)=0A0xffffffffbaa4a18d <blk_mq_q=
ueue_tag_busy_iter+285>:	mov    0x4(%rsp),%eax=0A0xffffffffbaa4a191 <blk_mq=
_queue_tag_busy_iter+289>:	cmp    %eax,0x40(%rcx)=0A0xffffffffbaa4a194 <blk=
_mq_queue_tag_busy_iter+292>:	ja     0xffffffffbaa4a0cd <blk_mq_queue_tag_b=
usy_iter+93>=0A0xffffffffbaa4a19a <blk_mq_queue_tag_busy_iter+298>:	mov    =
0x8(%rsp),%rdi=0A0xffffffffbaa4a19f <blk_mq_queue_tag_busy_iter+303>:	callq=
  0xffffffffbaa3b820 <blk_queue_exit>=0A0xffffffffbaa4a1a4 <blk_mq_queue_ta=
g_busy_iter+308>:	mov    0x58(%rsp),%rax=0A0xffffffffbaa4a1a9 <blk_mq_queue=
_tag_busy_iter+313>:	xor    %gs:0x28,%rax=0A0xffffffffbaa4a1b2 <blk_mq_queu=
e_tag_busy_iter+322>:	jne    0xffffffffbaa4a344 <blk_mq_queue_tag_busy_iter=
+724>=0A0xffffffffbaa4a1b8 <blk_mq_queue_tag_busy_iter+328>:	add    $0x60,%=
rsp=0A0xffffffffbaa4a1bc <blk_mq_queue_tag_busy_iter+332>:	pop    %rbx=0A0x=
ffffffffbaa4a1bd <blk_mq_queue_tag_busy_iter+333>:	pop    %rbp=0A0xffffffff=
baa4a1be <blk_mq_queue_tag_busy_iter+334>:	pop    %r12=0A0xffffffffbaa4a1c0=
 <blk_mq_queue_tag_busy_iter+336>:	pop    %r13=0A0xffffffffbaa4a1c2 <blk_mq=
_queue_tag_busy_iter+338>:	pop    %r14=0A0xffffffffbaa4a1c4 <blk_mq_queue_t=
ag_busy_iter+340>:	pop    %r15=0A0xffffffffbaa4a1c6 <blk_mq_queue_tag_busy_=
iter+342>:	retq   =0A0xffffffffbaa4a1c7 <blk_mq_queue_tag_busy_iter+343>:	m=
ov    %ebx,%r14d=0A0xffffffffbaa4a1ca <blk_mq_queue_tag_busy_iter+346>:	xor=
    %edx,%edx=0A0xffffffffbaa4a1cc <blk_mq_queue_tag_busy_iter+348>:	jmp   =
 0xffffffffbaa4a1d3 <blk_mq_queue_tag_busy_iter+355>=0A0xffffffffbaa4a1ce <=
blk_mq_queue_tag_busy_iter+350>:	lea    0x1(%r12),%edx=0A0xffffffffbaa4a1d3=
 <blk_mq_queue_tag_busy_iter+355>:	lea    0x30(%rsp),%rdi=0A0xffffffffbaa4a=
1d8 <blk_mq_queue_tag_busy_iter+360>:	mov    %r14,%rsi=0A0xffffffffbaa4a1db=
 <blk_mq_queue_tag_busy_iter+363>:	callq  0xffffffffbaa8b2d0 <find_next_bit=
>=0A0xffffffffbaa4a1e0 <blk_mq_queue_tag_busy_iter+368>:	cmp    %eax,%ebx=
=0A0xffffffffbaa4a1e2 <blk_mq_queue_tag_busy_iter+370>:	mov    %rax,%r12=0A=
0xffffffffbaa4a1e5 <blk_mq_queue_tag_busy_iter+373>:	jbe    0xffffffffbaa4a=
16c <blk_mq_queue_tag_busy_iter+252>=0A0xffffffffbaa4a1e7 <blk_mq_queue_tag=
_busy_iter+375>:	mov    0x4(%r15),%ecx=0A0xffffffffbaa4a1eb <blk_mq_queue_t=
ag_busy_iter+379>:	mov    %ebp,%esi=0A0xffffffffbaa4a1ed <blk_mq_queue_tag_=
busy_iter+381>:	lea    0x38(%rsp),%rdx=0A0xffffffffbaa4a1f2 <blk_mq_queue_t=
ag_busy_iter+386>:	mov    %r15,%rdi=0A0xffffffffbaa4a1f5 <blk_mq_queue_tag_=
busy_iter+389>:	shl    %cl,%esi=0A0xffffffffbaa4a1f7 <blk_mq_queue_tag_busy=
_iter+391>:	add    %eax,%esi=0A0xffffffffbaa4a1f9 <blk_mq_queue_tag_busy_it=
er+393>:	callq  0xffffffffbaa49880 <bt_iter>=0A0xffffffffbaa4a1fe <blk_mq_q=
ueue_tag_busy_iter+398>:	test   %al,%al=0A0xffffffffbaa4a200 <blk_mq_queue_=
tag_busy_iter+400>:	jne    0xffffffffbaa4a1ce <blk_mq_queue_tag_busy_iter+3=
50>=0A0xffffffffbaa4a202 <blk_mq_queue_tag_busy_iter+402>:	jmpq   0xfffffff=
fbaa4a183 <blk_mq_queue_tag_busy_iter+275>=0A0xffffffffbaa4a207 <blk_mq_que=
ue_tag_busy_iter+407>:	mov    0x10(%rsp),%rax=0A0xffffffffbaa4a20c <blk_mq_=
queue_tag_busy_iter+412>:	mov    0x18(%r14),%r15=0A0xffffffffbaa4a210 <blk_=
mq_queue_tag_busy_iter+416>:	xor    %r12d,%r12d=0A0xffffffffbaa4a213 <blk_m=
q_queue_tag_busy_iter+419>:	mov    %r13,0x38(%rsp)=0A0xffffffffbaa4a218 <bl=
k_mq_queue_tag_busy_iter+424>:	movb   $0x1,0x50(%rsp)=0A0xffffffffbaa4a21d =
<blk_mq_queue_tag_busy_iter+429>:	xor    %ebp,%ebp=0A0xffffffffbaa4a21f <bl=
k_mq_queue_tag_busy_iter+431>:	mov    %rax,0x40(%rsp)=0A0xffffffffbaa4a224 =
<blk_mq_queue_tag_busy_iter+436>:	mov    0x18(%rsp),%rax=0A0xffffffffbaa4a2=
29 <blk_mq_queue_tag_busy_iter+441>:	mov    %rax,0x48(%rsp)=0A0xffffffffbaa=
4a22e <blk_mq_queue_tag_busy_iter+446>:	mov    (%r15),%ebx=0A0xffffffffbaa4=
a231 <blk_mq_queue_tag_busy_iter+449>:	test   %ebx,%ebx=0A0xffffffffbaa4a23=
3 <blk_mq_queue_tag_busy_iter+451>:	je     0xffffffffbaa4a10a <blk_mq_queue=
_tag_busy_iter+154>=0A0xffffffffbaa4a239 <blk_mq_queue_tag_busy_iter+457>:	=
mov    %r13,0x20(%rsp)=0A0xffffffffbaa4a23e <blk_mq_queue_tag_busy_iter+462=
>:	mov    %r14,0x28(%rsp)=0A0xffffffffbaa4a243 <blk_mq_queue_tag_busy_iter+=
467>:	mov    %ebp,%eax=0A0xffffffffbaa4a245 <blk_mq_queue_tag_busy_iter+469=
>:	sub    %r12d,%ebx=0A0xffffffffbaa4a248 <blk_mq_queue_tag_busy_iter+472>:=
	lea    (%rax,%rax,2),%rax=0A0xffffffffbaa4a24c <blk_mq_queue_tag_busy_iter=
+476>:	shl    $0x6,%rax=0A0xffffffffbaa4a250 <blk_mq_queue_tag_busy_iter+48=
0>:	add    0x10(%r15),%rax=0A0xffffffffbaa4a254 <blk_mq_queue_tag_busy_iter=
+484>:	mov    (%rax),%rdx=0A0xffffffffbaa4a257 <blk_mq_queue_tag_busy_iter+=
487>:	cmp    %edx,%ebx=0A0xffffffffbaa4a259 <blk_mq_queue_tag_busy_iter+489=
>:	cmovae %edx,%ebx=0A0xffffffffbaa4a25c <blk_mq_queue_tag_busy_iter+492>:	=
mov    0x80(%rax),%rdx=0A0xffffffffbaa4a263 <blk_mq_queue_tag_busy_iter+499=
>:	add    %ebx,%r12d=0A0xffffffffbaa4a266 <blk_mq_queue_tag_busy_iter+502>:=
	not    %rdx=0A0xffffffffbaa4a269 <blk_mq_queue_tag_busy_iter+505>:	and    =
0x40(%rax),%rdx=0A0xffffffffbaa4a26d <blk_mq_queue_tag_busy_iter+509>:	test=
   %rdx,%rdx=0A0xffffffffbaa4a270 <blk_mq_queue_tag_busy_iter+512>:	mov    =
%rdx,0x30(%rsp)=0A0xffffffffbaa4a275 <blk_mq_queue_tag_busy_iter+517>:	jne =
   0xffffffffbaa4a29d <blk_mq_queue_tag_busy_iter+557>=0A0xffffffffbaa4a277=
 <blk_mq_queue_tag_busy_iter+519>:	add    $0x1,%ebp=0A0xffffffffbaa4a27a <b=
lk_mq_queue_tag_busy_iter+522>:	cmp    0x8(%r15),%ebp=0A0xffffffffbaa4a27e =
<blk_mq_queue_tag_busy_iter+526>:	mov    (%r15),%ebx=0A0xffffffffbaa4a281 <=
blk_mq_queue_tag_busy_iter+529>:	mov    $0x0,%eax=0A0xffffffffbaa4a286 <blk=
_mq_queue_tag_busy_iter+534>:	cmovae %eax,%ebp=0A0xffffffffbaa4a289 <blk_mq=
_queue_tag_busy_iter+537>:	cmp    %r12d,%ebx=0A0xffffffffbaa4a28c <blk_mq_q=
ueue_tag_busy_iter+540>:	ja     0xffffffffbaa4a243 <blk_mq_queue_tag_busy_i=
ter+467>=0A0xffffffffbaa4a28e <blk_mq_queue_tag_busy_iter+542>:	mov    0x20=
(%rsp),%r13=0A0xffffffffbaa4a293 <blk_mq_queue_tag_busy_iter+547>:	mov    0=
x28(%rsp),%r14=0A0xffffffffbaa4a298 <blk_mq_queue_tag_busy_iter+552>:	jmpq =
  0xffffffffbaa4a10a <blk_mq_queue_tag_busy_iter+154>=0A0xffffffffbaa4a29d =
<blk_mq_queue_tag_busy_iter+557>:	xor    %r8d,%r8d=0A0xffffffffbaa4a2a0 <bl=
k_mq_queue_tag_busy_iter+560>:	mov    %ebx,%r13d=0A0xffffffffbaa4a2a3 <blk_=
mq_queue_tag_busy_iter+563>:	mov    %r8d,%edx=0A0xffffffffbaa4a2a6 <blk_mq_=
queue_tag_busy_iter+566>:	jmp    0xffffffffbaa4a2ac <blk_mq_queue_tag_busy_=
iter+572>=0A0xffffffffbaa4a2a8 <blk_mq_queue_tag_busy_iter+568>:	lea    0x1=
(%r14),%edx=0A0xffffffffbaa4a2ac <blk_mq_queue_tag_busy_iter+572>:	lea    0=
x30(%rsp),%rdi=0A0xffffffffbaa4a2b1 <blk_mq_queue_tag_busy_iter+577>:	mov  =
  %r13,%rsi=0A0xffffffffbaa4a2b4 <blk_mq_queue_tag_busy_iter+580>:	callq  0=
xffffffffbaa8b2d0 <find_next_bit>=0A0xffffffffbaa4a2b9 <blk_mq_queue_tag_bu=
sy_iter+585>:	cmp    %eax,%ebx=0A0xffffffffbaa4a2bb <blk_mq_queue_tag_busy_=
iter+587>:	mov    %rax,%r14=0A0xffffffffbaa4a2be <blk_mq_queue_tag_busy_ite=
r+590>:	jbe    0xffffffffbaa4a277 <blk_mq_queue_tag_busy_iter+519>=0A0xffff=
ffffbaa4a2c0 <blk_mq_queue_tag_busy_iter+592>:	mov    0x4(%r15),%ecx=0A0xff=
ffffffbaa4a2c4 <blk_mq_queue_tag_busy_iter+596>:	mov    %ebp,%esi=0A0xfffff=
fffbaa4a2c6 <blk_mq_queue_tag_busy_iter+598>:	lea    0x38(%rsp),%rdx=0A0xff=
ffffffbaa4a2cb <blk_mq_queue_tag_busy_iter+603>:	mov    %r15,%rdi=0A0xfffff=
fffbaa4a2ce <blk_mq_queue_tag_busy_iter+606>:	shl    %cl,%esi=0A0xffffffffb=
aa4a2d0 <blk_mq_queue_tag_busy_iter+608>:	add    %eax,%esi=0A0xffffffffbaa4=
a2d2 <blk_mq_queue_tag_busy_iter+610>:	callq  0xffffffffbaa49880 <bt_iter>=
=0A0xffffffffbaa4a2d7 <blk_mq_queue_tag_busy_iter+615>:	test   %al,%al=0A0x=
ffffffffbaa4a2d9 <blk_mq_queue_tag_busy_iter+617>:	jne    0xffffffffbaa4a2a=
8 <blk_mq_queue_tag_busy_iter+568>=0A0xffffffffbaa4a2db <blk_mq_queue_tag_b=
usy_iter+619>:	mov    0x20(%rsp),%r13=0A0xffffffffbaa4a2e0 <blk_mq_queue_ta=
g_busy_iter+624>:	mov    0x28(%rsp),%r14=0A0xffffffffbaa4a2e5 <blk_mq_queue=
_tag_busy_iter+629>:	jmpq   0xffffffffbaa4a10a <blk_mq_queue_tag_busy_iter+=
154>=0A0xffffffffbaa4a2ea <blk_mq_queue_tag_busy_iter+634>:	mov    0x8(%rsp=
),%rax=0A0xffffffffbaa4a2ef <blk_mq_queue_tag_busy_iter+639>:	mov    0x5f8(=
%rax),%rdx=0A0xffffffffbaa4a2f6 <blk_mq_queue_tag_busy_iter+646>:	test   %r=
dx,%rdx=0A0xffffffffbaa4a2f9 <blk_mq_queue_tag_busy_iter+649>:	je     0xfff=
fffffbaa4a327 <blk_mq_queue_tag_busy_iter+695>=0A0xffffffffbaa4a2fb <blk_mq=
_queue_tag_busy_iter+651>:	mov    0x8(%rsp),%rdi=0A0xffffffffbaa4a300 <blk_=
mq_queue_tag_busy_iter+656>:	lea    0x1(%rdx),%rcx=0A0xffffffffbaa4a304 <bl=
k_mq_queue_tag_busy_iter+660>:	mov    %rdx,%rax=0A0xffffffffbaa4a307 <blk_m=
q_queue_tag_busy_iter+663>:	lea    0x5f8(%rdi),%rsi=0A0xffffffffbaa4a30e <b=
lk_mq_queue_tag_busy_iter+670>:	lock cmpxchg %rcx,0x5f8(%rdi)=0A0xffffffffb=
aa4a317 <blk_mq_queue_tag_busy_iter+679>:	jne    0xffffffffbaa4a32c <blk_mq=
_queue_tag_busy_iter+700>=0A0xffffffffbaa4a319 <blk_mq_queue_tag_busy_iter+=
681>:	test   %rdx,%rdx=0A0xffffffffbaa4a31c <blk_mq_queue_tag_busy_iter+684=
>:	jne    0xffffffffbaa4a0b5 <blk_mq_queue_tag_busy_iter+69>=0A0xffffffffba=
a4a322 <blk_mq_queue_tag_busy_iter+690>:	jmpq   0xffffffffbaa4a1a4 <blk_mq_=
queue_tag_busy_iter+308>=0A0xffffffffbaa4a327 <blk_mq_queue_tag_busy_iter+6=
95>:	jmpq   0xffffffffbaa4a1a4 <blk_mq_queue_tag_busy_iter+308>=0A0xfffffff=
fbaa4a32c <blk_mq_queue_tag_busy_iter+700>:	test   %rax,%rax=0A0xffffffffba=
a4a32f <blk_mq_queue_tag_busy_iter+703>:	mov    %rax,%rdx=0A0xffffffffbaa4a=
332 <blk_mq_queue_tag_busy_iter+706>:	je     0xffffffffbaa4a319 <blk_mq_que=
ue_tag_busy_iter+681>=0A0xffffffffbaa4a334 <blk_mq_queue_tag_busy_iter+708>=
:	lea    0x1(%rdx),%rcx=0A0xffffffffbaa4a338 <blk_mq_queue_tag_busy_iter+71=
2>:	mov    %rdx,%rax=0A0xffffffffbaa4a33b <blk_mq_queue_tag_busy_iter+715>:=
	lock cmpxchg %rcx,(%rsi)=0A0xffffffffbaa4a340 <blk_mq_queue_tag_busy_iter+=
720>:	je     0xffffffffbaa4a319 <blk_mq_queue_tag_busy_iter+681>=0A0xffffff=
ffbaa4a342 <blk_mq_queue_tag_busy_iter+722>:	jmp    0xffffffffbaa4a32c <blk=
_mq_queue_tag_busy_iter+700>=0A0xffffffffbaa4a344 <blk_mq_queue_tag_busy_it=
er+724>:	callq  0xffffffffba69d3c0 <__stack_chk_fail>=0A0xffffffffbaa4a349 =
<blk_mq_queue_tag_busy_iter+729>:	nopl   0x0(%rax)=0A
--z5lccj23sq3wwiaf--

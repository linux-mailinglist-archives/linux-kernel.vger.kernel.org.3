Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B816B4F8BC5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 02:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbiDHAuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 20:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiDHAu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 20:50:28 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4560526ACF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 17:48:26 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2eb8c0ddcf6so62321367b3.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 17:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ithdVlozh5jFC5LDPPJEaLYRLxUsUDLKrVaBbck8woI=;
        b=omXiV0brS6SC4fAsszjr3vh7SFO8aEPobqoxOFDY5gSXD4t7YUUrTf7kvD2voWFdGR
         0zfKeLrkPKhiVG1D/WWtxb29Iv343o7BnI/AvfEqwHDPJmrMzF1O3Vnpao8P0/fXyCgx
         nY3TY7bOcVwFNQFpshyTnzdQgZOwX7Q1RBQCrzsncOpPhEbEyqD2cFwzhTN4wfmDFPs5
         MekcHDrPOPryJQWDeii7ymb0dhrvpcoLFAtJ70AuD4FM5oNiUWAjY4U2/aOY8j1hxnrv
         2Ha/emP+PaKxv0PdcVrgerBl0AxigiyEeU0+NcNeFRn8UX2MwLAuPhkTGPDKgIXxlgUI
         6olQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ithdVlozh5jFC5LDPPJEaLYRLxUsUDLKrVaBbck8woI=;
        b=Ywv4wN+ezdGr/tCbzDOQOCqG8MEsw8cadfXMxHaab8M8eRl8lSF9Ln4NmnvwA5DmAe
         rWgegvtiYjsMbGfrbxdyHQOU+xLbopD9shrxZXn9M2OMnbmeRbarBpuV6YhlA1txgwCn
         sufI/JFMpOKXfv3mpHPJOvXfekvivFCAn1qUq784S35eN6oRCQN0PwpxfMYLTin+Uwan
         1tA7IHIyJW9oMiBvoXxJjBkNvPuXX3pEMpTuGhUZpyTioY0ADDVYNQwm8cryJ5bu9Yfy
         ka9wPNmnZC2yVWsvg+kSSPTS7FqDLL1QpU9KQPAot0attw5wCMHTDboBdA3unUGkxtpH
         gkBw==
X-Gm-Message-State: AOAM530PyvB7Uiob3IdhjQrUE/VJr4RvZohF+Lp2KKU8v43Oxy+1urKm
        5WiQjuiNq2blnlm/gyRsB4viEUlPMiyZNhU=
X-Google-Smtp-Source: ABdhPJxZfTDhCmiUWxemMxtmOYKdXt8UIDGz1EMPXmcT+4UwQKXx3DIeNZNwfDy6tGznTHCK1StYatP5YLU97sQ=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:b203:eb20:896d:ef2f])
 (user=saravanak job=sendgmr) by 2002:a05:6902:1d1:b0:636:fa07:4b9a with SMTP
 id u17-20020a05690201d100b00636fa074b9amr12044080ybh.590.1649378905528; Thu,
 07 Apr 2022 17:48:25 -0700 (PDT)
Date:   Thu,  7 Apr 2022 17:48:21 -0700
In-Reply-To: <YXlddJxLh77DKfIO@alley>
Message-Id: <20220408004821.4010969-1-saravanak@google.com>
Mime-Version: 1.0
References: <YXlddJxLh77DKfIO@alley>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: Re: [PATCH v2] printk: ringbuffer: Improve prb_next_seq() performance
From:   Saravana Kannan <saravanak@google.com>
To:     pmladek@suse.com, Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chunlei.wang@mediatek.com, john.ogness@linutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, rostedt@goodmis.org,
        senozhatsky@chromium.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Petr Mladek <pmladek@suse.com> wrote:
> 
> prb_next_seq() always iterates from the first known sequence number.
> In the worst case, it might loop 8k times for 256kB buffer,
> 15k times for 512kB buffer, and 64k times for 2MB buffer.
> 
> It was reported that pooling and reading using syslog interface
> might occupy 50% of CPU.
> 
> Speedup the search by storing @id of the last finalized descriptor.
> 
> The loop is still needed because the @id is stored and read in the best
> effort way. An atomic variable is used to keep the @id consistent.
> But the stores and reads are not serialized against each other.
> The descriptor could get reused in the meantime. The related sequence
> number will be used only when it is still valid.
> 
> An invalid value should be read _only_ when there is a flood of messages
> and the ringbuffer is rapidly reused. The performance is the least
> problem in this case.
> 
> Reported-by: Chunlei Wang <chunlei.wang@mediatek.com>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
> Changes against v1:
> 
>   + Read @seq by the last finalized @id directly in prb_next_seq() (John)
> 
>  kernel/printk/printk_ringbuffer.c | 49 ++++++++++++++++++++++++++++---
>  kernel/printk/printk_ringbuffer.h |  2 ++
>  2 files changed, 47 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> index 8a7b7362c0dd..24f47fbefbb5 100644
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -474,8 +474,10 @@ static enum desc_state desc_read(struct prb_desc_ring *desc_ring,
>  	 * state has been re-checked. A memcpy() for all of @desc
>  	 * cannot be used because of the atomic_t @state_var field.
>  	 */
> -	memcpy(&desc_out->text_blk_lpos, &desc->text_blk_lpos,
> -	       sizeof(desc_out->text_blk_lpos)); /* LMM(desc_read:C) */
> +	if (desc_out) {
> +		memcpy(&desc_out->text_blk_lpos, &desc->text_blk_lpos,
> +		       sizeof(desc_out->text_blk_lpos)); /* LMM(desc_read:C) */
> +	}
>  	if (seq_out)
>  		*seq_out = info->seq; /* also part of desc_read:C */
>  	if (caller_id_out)
> @@ -1449,6 +1451,9 @@ static void desc_make_final(struct prb_desc_ring *desc_ring, unsigned long id)
>  
>  	atomic_long_cmpxchg_relaxed(&d->state_var, prev_state_val,
>  			DESC_SV(id, desc_finalized)); /* LMM(desc_make_final:A) */
> +
> +	/* Best effort to remember the last finalized @id. */
> +	atomic_long_set(&desc_ring->last_finalized_id, id);
>  }
>  
>  /**
> @@ -1657,7 +1662,12 @@ void prb_commit(struct prb_reserved_entry *e)
>   */
>  void prb_final_commit(struct prb_reserved_entry *e)
>  {
> +	struct prb_desc_ring *desc_ring = &e->rb->desc_ring;
> +
>  	_prb_commit(e, desc_finalized);
> +
> +	/* Best effort to remember the last finalized @id. */
> +	atomic_long_set(&desc_ring->last_finalized_id, e->id);
>  }
>  
>  /*
> @@ -2005,9 +2015,39 @@ u64 prb_first_valid_seq(struct printk_ringbuffer *rb)
>   */
>  u64 prb_next_seq(struct printk_ringbuffer *rb)
>  {
> -	u64 seq = 0;
> +	struct prb_desc_ring *desc_ring = &rb->desc_ring;
> +	enum desc_state d_state;
> +	unsigned long id;
> +	u64 seq;
> +
> +	/* Check if the cached @id still points to a valid @seq. */
> +	id = atomic_long_read(&desc_ring->last_finalized_id);
> +	d_state = desc_read(desc_ring, id, NULL, &seq, NULL);
>  
> -	/* Search forward from the oldest descriptor. */
> +	if (d_state == desc_finalized || d_state == desc_reusable) {
> +		/*
> +		 * Begin searching after the last finalized record.
> +		 *
> +		 * On 0, the search must begin at 0 because of hack#2
> +		 * of the bootstrapping phase it is not known if a
> +		 * record at index 0 exists.
> +		 */
> +		if (seq != 0)
> +			seq++;
> +	} else {
> +		/*
> +		 * The information about the last finalized sequence number
> +		 * has gone. It should happen only when there is a flood of
> +		 * new messages and the ringbuffer is rapidly recycled.
> +		 * Give up and start from the beginning.
> +		 */
> +		seq = 0;
> +	}
> +
> +	/*
> +	 * The information about the last finalized @seq might be inaccurate.
> +	 * Search forward to find the current one.
> +	 */
>  	while (_prb_read_valid(rb, &seq, NULL, NULL))
>  		seq++;
>  
> @@ -2044,6 +2084,7 @@ void prb_init(struct printk_ringbuffer *rb,
>  	rb->desc_ring.infos = infos;
>  	atomic_long_set(&rb->desc_ring.head_id, DESC0_ID(descbits));
>  	atomic_long_set(&rb->desc_ring.tail_id, DESC0_ID(descbits));
> +	atomic_long_set(&rb->desc_ring.last_finalized_id, DESC0_ID(descbits));
>  
>  	rb->text_data_ring.size_bits = textbits;
>  	rb->text_data_ring.data = text_buf;
> diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
> index 73cc80e01cef..18cd25e489b8 100644
> --- a/kernel/printk/printk_ringbuffer.h
> +++ b/kernel/printk/printk_ringbuffer.h
> @@ -75,6 +75,7 @@ struct prb_desc_ring {
>  	struct printk_info	*infos;
>  	atomic_long_t		head_id;
>  	atomic_long_t		tail_id;
> +	atomic_long_t		last_finalized_id;
>  };


I really know nothing about this code, but while looking around
kernel/printk/ I noticed kernel/printk/printk.c has these lines in
log_buf_vmcoreinfo_setup().

	VMCOREINFO_STRUCT_SIZE(prb_desc_ring);
	VMCOREINFO_OFFSET(prb_desc_ring, count_bits);
	VMCOREINFO_OFFSET(prb_desc_ring, descs);
	VMCOREINFO_OFFSET(prb_desc_ring, infos);
	VMCOREINFO_OFFSET(prb_desc_ring, head_id);
	VMCOREINFO_OFFSET(prb_desc_ring, tail_id);

Would this header file change also require a change to that location?
Something like

	VMCOREINFO_OFFSET(prb_desc_ring, head_id);
	VMCOREINFO_OFFSET(prb_desc_ring, tail_id);
+	VMCOREINFO_OFFSET(prb_desc_ring, last_finalized_id);

-Saravana

>  
>  /*
> @@ -258,6 +259,7 @@ static struct printk_ringbuffer name = {							\
>  		.infos		= &_##name##_infos[0],						\
>  		.head_id	= ATOMIC_INIT(DESC0_ID(descbits)),				\
>  		.tail_id	= ATOMIC_INIT(DESC0_ID(descbits)),				\
> +		.last_finalized_id = ATOMIC_INIT(DESC0_ID(descbits)),				\
>  	},											\
>  	.text_data_ring = {									\
>  		.size_bits	= (avgtextbits) + (descbits),					\
> -- 
> 2.26.2
> 

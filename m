Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B57253E627
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239448AbiFFOUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239809AbiFFOUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:20:08 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32121113FB4;
        Mon,  6 Jun 2022 07:20:06 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id b8so2361010edj.11;
        Mon, 06 Jun 2022 07:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=i13OIJLIHwM2QopjWJmPKjWdBcn10+WTSMzaG2PDlNQ=;
        b=O/6hrfO/uBCIiP57CDFh1HrNdy29W2Zxk+as6GK01YqQrsckHiiz6/tRBDobB7sFGi
         rRudju1RScx4FBx0hvCkSOl/E/UKbdok6KPNVH1+SVwAFUv+OtdzIoUkRVZmH8bOYlEt
         WQ4ShW7Odkn2aGBFcLxGhGFXuENKMDgkMQlMJhg5858zurtHljr26oBk/wyYbEo3XXUS
         HZlgZ92cAoiZPqKFcOcfdUAryKA6bDACjTwsfzBz02LMZQgV8DSgojga6GRi2aGCYIhT
         WeuXRO19LJcUUUYUYwBtOJq4z2IyNT8YbRzWus/lcnpNKoUwUCIeXu3g6naMMVAdqa1Z
         CQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=i13OIJLIHwM2QopjWJmPKjWdBcn10+WTSMzaG2PDlNQ=;
        b=VYU/hpMDqk6TU7WPFx/RAoNsG0jQZdgeXDzKYta+RrELvnGTRUsVG4lqTYYcokq6UL
         qR5zGUh918RBc3E1UjhvoRhc75ThTSt005xVrZj+czytc8HZKPNcbCs8UW3VOnZ9Z9Vv
         hwdcgVq+3CG168uR/EdA+r/WpIoS5rWzogTGwrDREscLSWTM2Q6voLlNKn3MAm0ZyG4B
         xvWZr6ug17PIFov6PwwW+DC9W1xSXHska1TJW7MGwKTlFTF/NS4RFg5cbQ7hIvcQM1QA
         8g2KCgC5Tsj69EjfVjquW99P7dEw/t1Ijz7koi3oD+Ccvh99D0ax09CFNdOLLsij9fRb
         pbWw==
X-Gm-Message-State: AOAM5325bZ9j3VYDFDgpIPnuWcuqgLjuvSpU+K1GjSO/t2JUm5OG42Qu
        bF6R1Yd5GKUxImJh/qnx5OOx/tbEmQ6mNqdAugQ=
X-Google-Smtp-Source: ABdhPJxi0zT1FV/9w4SKXqwZ2mGhYecGi9FSXOqwCh5eMsLQFVoNOCeycekZ8rQmpb4XdVaRcv/PsLH65ayPOOumDiQ=
X-Received: by 2002:aa7:d303:0:b0:42d:d192:4c41 with SMTP id
 p3-20020aa7d303000000b0042dd1924c41mr27591079edq.178.1654525204466; Mon, 06
 Jun 2022 07:20:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220606133215.57537-1-ilpo.jarvinen@linux.intel.com> <20220606133215.57537-2-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20220606133215.57537-2-ilpo.jarvinen@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 6 Jun 2022 16:19:28 +0200
Message-ID: <CAHp75VdYQbsBhUsH6eW2DMrDaDpyEPYFYbJpRVTBSR7P0dz+SQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] tty: Implement lookahead to process XON/XOFF timely
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gilles Buloz <gilles.buloz@kontron.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 6, 2022 at 3:45 PM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> When tty is not read from, XON/XOFF may get stuck into an
> intermediate buffer. As those characters are there to do software
> flow-control, it is not very useful. In the case where neither end
> reads from ttys, the receiving ends might not be able receive the
> XOFF characters and just keep sending more data to the opposite
> direction. This problem is almost guaranteed to occur with DMA
> which sends data in large chunks.
>
> If TTY is slow to process characters, that is, eats less than given
> amount in receive_buf, invoke lookahead for the rest of the chars
> to process potential XON/XOFF characters.
>
> We need to keep track of how many characters have been processed by the
> lookahead to avoid processing the flow control char again on the normal
> path. Bookkeeping occurs parallel on two layers (tty_buffer and n_tty)
> to avoid passing the lookahead_count through the whole callchain.

call chain

> When a flow-control char is processed, two things must occur:
>   a) it must not be treated as normal char
>   b) if not yet processed, flow-control actions need to be taken
> The return value of n_tty_receive_char_flow_ctrl() tells caller a), and
> b) is kept internal to n_tty_receive_char_flow_ctrl().
>
> If characters were previous looked ahead, __receive_buf() makes two
> calls to the approriate n_tty_receive_buf_* function. First call is

appropriate

> made with lookahead_done=3Dtrue for the characters that were subject to
> lookahead earlier and then with lookahead=3Dfalse for the new characters.
> Either of the calls might be skipped when it has no characters to
> handle.

Seems good to me, but I am not an expert in TTY layer, perhaps Jiri or
somebody else who is more familiar with this can look into. I can
suggest to add Johan Hovold (because he maintains USB serial) and Rob
Herring (because he introduced serdev).

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Also see a few nit-picks below.

> Reported-by: Gilles Buloz <gilles.buloz@kontron.com>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/tty/n_tty.c        | 90 +++++++++++++++++++++++++++++++-------
>  drivers/tty/tty_buffer.c   | 59 +++++++++++++++++++++----
>  drivers/tty/tty_port.c     | 21 +++++++++
>  include/linux/tty_buffer.h |  1 +
>  include/linux/tty_ldisc.h  | 13 ++++++
>  include/linux/tty_port.h   |  2 +
>  6 files changed, 161 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> index 640c9e871044..917b5970b2e0 100644
> --- a/drivers/tty/n_tty.c
> +++ b/drivers/tty/n_tty.c
> @@ -118,6 +118,9 @@ struct n_tty_data {
>         size_t read_tail;
>         size_t line_start;
>
> +       /* # of chars looked ahead (to find software flow control chars) =
*/
> +       size_t lookahead_count;
> +
>         /* protected by output lock */
>         unsigned int column;
>         unsigned int canon_column;
> @@ -333,6 +336,8 @@ static void reset_buffer_flags(struct n_tty_data *lda=
ta)
>         ldata->erasing =3D 0;
>         bitmap_zero(ldata->read_flags, N_TTY_BUF_SIZE);
>         ldata->push =3D 0;
> +
> +       ldata->lookahead_count =3D 0;
>  }
>
>  static void n_tty_packet_mode_flush(struct tty_struct *tty)
> @@ -1225,12 +1230,30 @@ static bool n_tty_is_char_flow_ctrl(struct tty_st=
ruct *tty, unsigned char c)
>         return c =3D=3D START_CHAR(tty) || c =3D=3D STOP_CHAR(tty);
>  }
>
> -/* Returns true if c is consumed as flow-control character */
> -static bool n_tty_receive_char_flow_ctrl(struct tty_struct *tty, unsigne=
d char c)
> +/**
> + * n_tty_receive_char_flow_ctrl - receive flow control chars
> + * @tty: terminal device
> + * @c: character
> + * @lookahead_done: lookahead has processed this character already
> + *
> + * Receive and process flow control character actions.
> + *
> + * In case lookahead for flow control chars already handled the characte=
r in
> + * advance to the normal receive, the actions are skipped during normal
> + * receive.
> + *
> + * Returns true if c is consumed as flow-control character, the characte=
r

@c

> + * must not be treated as normal character.
> + */
> +static bool n_tty_receive_char_flow_ctrl(struct tty_struct *tty, unsigne=
d char c,
> +                                        bool lookahead_done)
>  {
>         if (!n_tty_is_char_flow_ctrl(tty, c))
>                 return false;
>
> +       if (lookahead_done)
> +               return true;
> +
>         if (c =3D=3D START_CHAR(tty)) {
>                 start_tty(tty);
>                 process_echoes(tty);
> @@ -1242,11 +1265,12 @@ static bool n_tty_receive_char_flow_ctrl(struct t=
ty_struct *tty, unsigned char c
>         return true;
>  }
>
> -static void n_tty_receive_char_special(struct tty_struct *tty, unsigned =
char c)
> +static void n_tty_receive_char_special(struct tty_struct *tty, unsigned =
char c,
> +                                      bool lookahead_done)
>  {
>         struct n_tty_data *ldata =3D tty->disc_data;
>
> -       if (I_IXON(tty) && n_tty_receive_char_flow_ctrl(tty, c))
> +       if (I_IXON(tty) && n_tty_receive_char_flow_ctrl(tty, c, lookahead=
_done))
>                 return;
>
>         if (L_ISIG(tty)) {
> @@ -1401,7 +1425,8 @@ static void n_tty_receive_char(struct tty_struct *t=
ty, unsigned char c)
>         put_tty_queue(c, ldata);
>  }
>
> -static void n_tty_receive_char_closing(struct tty_struct *tty, unsigned =
char c)
> +static void n_tty_receive_char_closing(struct tty_struct *tty, unsigned =
char c,
> +                                      bool lookahead_done)
>  {
>         if (I_ISTRIP(tty))
>                 c &=3D 0x7f;
> @@ -1409,9 +1434,12 @@ static void n_tty_receive_char_closing(struct tty_=
struct *tty, unsigned char c)
>                 c =3D tolower(c);
>
>         if (I_IXON(tty)) {
> -               if (c =3D=3D STOP_CHAR(tty))
> -                       stop_tty(tty);
> -               else if (c =3D=3D START_CHAR(tty) ||
> +               if (c =3D=3D STOP_CHAR(tty)) {
> +                       if (!lookahead_done)
> +                               stop_tty(tty);
> +               } else if (c =3D=3D START_CHAR(tty) && lookahead_done) {
> +                       return;
> +               } else if (c =3D=3D START_CHAR(tty) ||
>                          (tty->flow.stopped && !tty->flow.tco_stopped && =
I_IXANY(tty) &&
>                           c !=3D INTR_CHAR(tty) && c !=3D QUIT_CHAR(tty) =
&&
>                           c !=3D SUSP_CHAR(tty))) {
> @@ -1457,6 +1485,26 @@ n_tty_receive_char_lnext(struct tty_struct *tty, u=
nsigned char c, char flag)
>                 n_tty_receive_char_flagged(tty, c, flag);
>  }
>
> +static void n_tty_lookahead_flow_ctrl(struct tty_struct *tty, const unsi=
gned char *cp,
> +                                     const unsigned char *fp, unsigned i=
nt count)
> +{
> +       struct n_tty_data *ldata =3D tty->disc_data;
> +       unsigned char flag =3D TTY_NORMAL;
> +
> +       ldata->lookahead_count +=3D count;
> +
> +       if (!I_IXON(tty))
> +               return;

> +       while (count--) {

If count =3D=3D 0 at the beginning of this function, this becomes an
infinite loop, perhaps adding a comment that explains that this never
happens?

> +               if (fp)
> +                       flag =3D *fp++;
> +               if (likely(flag =3D=3D TTY_NORMAL))
> +                       n_tty_receive_char_flow_ctrl(tty, *cp, false);
> +               cp++;
> +       }
> +}
> +
>  static void
>  n_tty_receive_buf_real_raw(struct tty_struct *tty, const unsigned char *=
cp,
>                            const char *fp, int count)
> @@ -1496,7 +1544,7 @@ n_tty_receive_buf_raw(struct tty_struct *tty, const=
 unsigned char *cp,
>
>  static void
>  n_tty_receive_buf_closing(struct tty_struct *tty, const unsigned char *c=
p,
> -                         const char *fp, int count)
> +                         const char *fp, int count, bool lookahead_done)
>  {
>         char flag =3D TTY_NORMAL;
>
> @@ -1504,12 +1552,12 @@ n_tty_receive_buf_closing(struct tty_struct *tty,=
 const unsigned char *cp,
>                 if (fp)
>                         flag =3D *fp++;
>                 if (likely(flag =3D=3D TTY_NORMAL))
> -                       n_tty_receive_char_closing(tty, *cp++);
> +                       n_tty_receive_char_closing(tty, *cp++, lookahead_=
done);
>         }
>  }
>
>  static void n_tty_receive_buf_standard(struct tty_struct *tty,
> -               const unsigned char *cp, const char *fp, int count)
> +               const unsigned char *cp, const char *fp, int count, bool =
lookahead_done)
>  {
>         struct n_tty_data *ldata =3D tty->disc_data;
>         char flag =3D TTY_NORMAL;
> @@ -1540,7 +1588,7 @@ static void n_tty_receive_buf_standard(struct tty_s=
truct *tty,
>                 }
>
>                 if (test_bit(c, ldata->char_map))
> -                       n_tty_receive_char_special(tty, c);
> +                       n_tty_receive_char_special(tty, c, lookahead_done=
);
>                 else
>                         n_tty_receive_char(tty, c);
>         }
> @@ -1551,21 +1599,30 @@ static void __receive_buf(struct tty_struct *tty,=
 const unsigned char *cp,
>  {
>         struct n_tty_data *ldata =3D tty->disc_data;
>         bool preops =3D I_ISTRIP(tty) || (I_IUCLC(tty) && L_IEXTEN(tty));
> +       size_t la_count =3D min_t(size_t, ldata->lookahead_count, count);
>
>         if (ldata->real_raw)
>                 n_tty_receive_buf_real_raw(tty, cp, fp, count);
>         else if (ldata->raw || (L_EXTPROC(tty) && !preops))
>                 n_tty_receive_buf_raw(tty, cp, fp, count);
> -       else if (tty->closing && !L_EXTPROC(tty))
> -               n_tty_receive_buf_closing(tty, cp, fp, count);
> -       else {
> -               n_tty_receive_buf_standard(tty, cp, fp, count);
> +       else if (tty->closing && !L_EXTPROC(tty)) {
> +               if (la_count > 0)
> +                       n_tty_receive_buf_closing(tty, cp, fp, la_count, =
true);
> +               if (count > la_count)
> +                       n_tty_receive_buf_closing(tty, cp, fp, count - la=
_count, false);
> +       } else {
> +               if (la_count > 0)
> +                       n_tty_receive_buf_standard(tty, cp, fp, la_count,=
 true);
> +               if (count > la_count)
> +                       n_tty_receive_buf_standard(tty, cp, fp, count - l=
a_count, false);
>
>                 flush_echoes(tty);
>                 if (tty->ops->flush_chars)
>                         tty->ops->flush_chars(tty);
>         }
>
> +       ldata->lookahead_count -=3D la_count;
> +
>         if (ldata->icanon && !L_EXTPROC(tty))
>                 return;
>
> @@ -2446,6 +2503,7 @@ static struct tty_ldisc_ops n_tty_ops =3D {
>         .receive_buf     =3D n_tty_receive_buf,
>         .write_wakeup    =3D n_tty_write_wakeup,
>         .receive_buf2    =3D n_tty_receive_buf2,
> +       .lookahead_buf   =3D n_tty_lookahead_flow_ctrl,
>  };
>
>  /**
> diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
> index bfa431a8e690..754fa43670cc 100644
> --- a/drivers/tty/tty_buffer.c
> +++ b/drivers/tty/tty_buffer.c
> @@ -5,6 +5,7 @@
>
>  #include <linux/types.h>
>  #include <linux/errno.h>
> +#include <linux/minmax.h>
>  #include <linux/tty.h>
>  #include <linux/tty_driver.h>
>  #include <linux/tty_flip.h>
> @@ -104,6 +105,7 @@ static void tty_buffer_reset(struct tty_buffer *p, si=
ze_t size)
>         p->size =3D size;
>         p->next =3D NULL;
>         p->commit =3D 0;
> +       p->lookahead =3D 0;
>         p->read =3D 0;
>         p->flags =3D 0;
>  }
> @@ -234,6 +236,7 @@ void tty_buffer_flush(struct tty_struct *tty, struct =
tty_ldisc *ld)
>                 buf->head =3D next;
>         }
>         buf->head->read =3D buf->head->commit;
> +       buf->head->lookahead =3D buf->head->read;
>
>         if (ld && ld->ops->flush_buffer)
>                 ld->ops->flush_buffer(tty);
> @@ -276,13 +279,15 @@ static int __tty_buffer_request_room(struct tty_por=
t *port, size_t size,
>                 if (n !=3D NULL) {
>                         n->flags =3D flags;
>                         buf->tail =3D n;
> -                       /* paired w/ acquire in flush_to_ldisc(); ensures
> -                        * flush_to_ldisc() sees buffer data.
> +                       /*
> +                        * Paired w/ acquire in flush_to_ldisc() and look=
ahead_bufs()
> +                        * ensures they see all buffer data.
>                          */
>                         smp_store_release(&b->commit, b->used);
> -                       /* paired w/ acquire in flush_to_ldisc(); ensures=
 the
> -                        * latest commit value can be read before the hea=
d is
> -                        * advanced to the next buffer
> +                       /*
> +                        * Paired w/ acquire in flush_to_ldisc() and look=
ahead_bufs()
> +                        * ensures the latest commit value can be read be=
fore the head
> +                        * is advanced to the next buffer.
>                          */
>                         smp_store_release(&b->next, n);
>                 } else if (change)
> @@ -459,6 +464,40 @@ int tty_ldisc_receive_buf(struct tty_ldisc *ld, cons=
t unsigned char *p,
>  }
>  EXPORT_SYMBOL_GPL(tty_ldisc_receive_buf);
>
> +static void lookahead_bufs(struct tty_port *port, struct tty_buffer *hea=
d)
> +{
> +       head->lookahead =3D max(head->lookahead, head->read);
> +
> +       while (head) {
> +               struct tty_buffer *next;
> +               unsigned char *p, *f =3D NULL;
> +               unsigned int count;
> +
> +               /*
> +                * Paired w/ release in __tty_buffer_request_room();
> +                * ensures commit value read is not stale if the head
> +                * is advancing to the next buffer.
> +                */
> +               next =3D smp_load_acquire(&head->next);
> +               /*
> +                * Paired w/ release in __tty_buffer_request_room() or in
> +                * tty_buffer_flush(); ensures we see the committed buffe=
r data.
> +                */
> +               count =3D smp_load_acquire(&head->commit) - head->lookahe=
ad;
> +               if (!count) {
> +                       head =3D next;
> +                       continue;
> +               }
> +
> +               p =3D char_buf_ptr(head, head->lookahead);
> +               if (~head->flags & TTYB_NORMAL)
> +                       f =3D flag_buf_ptr(head, head->lookahead);
> +
> +               port->client_ops->lookahead_buf(port, p, f, count);
> +               head->lookahead +=3D count;
> +       }
> +}
> +
>  static int
>  receive_buf(struct tty_port *port, struct tty_buffer *head, int count)
>  {
> @@ -496,7 +535,7 @@ static void flush_to_ldisc(struct work_struct *work)
>         while (1) {
>                 struct tty_buffer *head =3D buf->head;
>                 struct tty_buffer *next;
> -               int count;
> +               int count, rcvd;
>
>                 /* Ldisc or user is trying to gain exclusive access */
>                 if (atomic_read(&buf->priority))
> @@ -519,10 +558,12 @@ static void flush_to_ldisc(struct work_struct *work=
)
>                         continue;
>                 }
>
> -               count =3D receive_buf(port, head, count);
> -               if (!count)
> +               rcvd =3D receive_buf(port, head, count);
> +               head->read +=3D rcvd;
> +               if (rcvd < count)
> +                       lookahead_bufs(port, head);
> +               if (!rcvd)
>                         break;
> -               head->read +=3D count;
>
>                 if (need_resched())
>                         cond_resched();
> diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
> index 880608a65773..dce08a6d7b5e 100644
> --- a/drivers/tty/tty_port.c
> +++ b/drivers/tty/tty_port.c
> @@ -43,6 +43,26 @@ static int tty_port_default_receive_buf(struct tty_por=
t *port,
>         return ret;
>  }
>
> +static void tty_port_default_lookahead_buf(struct tty_port *port, const =
unsigned char *p,
> +                                          const unsigned char *f, unsign=
ed int count)
> +{
> +       struct tty_struct *tty;
> +       struct tty_ldisc *disc;
> +
> +       tty =3D READ_ONCE(port->itty);
> +       if (!tty)
> +               return;
> +
> +       disc =3D tty_ldisc_ref(tty);
> +       if (!disc)
> +               return;
> +
> +       if (disc->ops->lookahead_buf)
> +               disc->ops->lookahead_buf(disc->tty, p, f, count);
> +
> +       tty_ldisc_deref(disc);
> +}
> +
>  static void tty_port_default_wakeup(struct tty_port *port)
>  {
>         struct tty_struct *tty =3D tty_port_tty_get(port);
> @@ -55,6 +75,7 @@ static void tty_port_default_wakeup(struct tty_port *po=
rt)
>
>  const struct tty_port_client_operations tty_port_default_client_ops =3D =
{
>         .receive_buf =3D tty_port_default_receive_buf,
> +       .lookahead_buf =3D tty_port_default_lookahead_buf,
>         .write_wakeup =3D tty_port_default_wakeup,
>  };
>  EXPORT_SYMBOL_GPL(tty_port_default_client_ops);
> diff --git a/include/linux/tty_buffer.h b/include/linux/tty_buffer.h
> index 3b9d77604291..1796648c2907 100644
> --- a/include/linux/tty_buffer.h
> +++ b/include/linux/tty_buffer.h
> @@ -15,6 +15,7 @@ struct tty_buffer {
>         int used;
>         int size;
>         int commit;
> +       int lookahead;          /* Lazy update on recv, can become less t=
han "read" */
>         int read;
>         int flags;
>         /* Data points here */
> diff --git a/include/linux/tty_ldisc.h b/include/linux/tty_ldisc.h
> index e85002b56752..bf8143fbcff3 100644
> --- a/include/linux/tty_ldisc.h
> +++ b/include/linux/tty_ldisc.h
> @@ -186,6 +186,17 @@ int ldsem_down_write_nested(struct ld_semaphore *sem=
, int subclass,
>   *     indicate all data received is %TTY_NORMAL. If assigned, prefer th=
is
>   *     function for automatic flow control.
>   *
> + * @lookahead_buf: [DRV] ``void ()(struct tty_struct *tty,
> + *                     const unsigned char *cp, const char *fp, int coun=
t)
> + *
> + *     This function is called by the low-level tty driver for character=
s
> + *     not eaten by receive_buf or receive_buf2. It is useful for proces=
sing

... by ->receive_buf() or ->receive_buf2().

> + *     high-priority characters such as software flow-control characters=
 that
> + *     could otherwise get stuck into the intermediate buffer until tty =
has
> + *     room to receive them. Ldisc must be able to handle later a receiv=
e_buf
> + *     or receive_buf2 call for the same characters (e.g. by skipping th=
e

Ditto.

> + *     actions for high-priority characters already handled by lookahead=
_buf).

Similar.

> + *
>   * @owner: module containting this ldisc (for reference counting)
>   *
>   * This structure defines the interface between the tty line discipline
> @@ -229,6 +240,8 @@ struct tty_ldisc_ops {
>         void    (*dcd_change)(struct tty_struct *tty, unsigned int status=
);
>         int     (*receive_buf2)(struct tty_struct *tty, const unsigned ch=
ar *cp,
>                                 const char *fp, int count);
> +       void    (*lookahead_buf)(struct tty_struct *tty, const unsigned c=
har *cp,
> +                                const unsigned char *fp, unsigned int co=
unt);
>
>         struct  module *owner;
>  };
> diff --git a/include/linux/tty_port.h b/include/linux/tty_port.h
> index 58e9619116b7..fa3c3bdaa234 100644
> --- a/include/linux/tty_port.h
> +++ b/include/linux/tty_port.h
> @@ -40,6 +40,8 @@ struct tty_port_operations {
>
>  struct tty_port_client_operations {
>         int (*receive_buf)(struct tty_port *port, const unsigned char *, =
const unsigned char *, size_t);
> +       void (*lookahead_buf)(struct tty_port *port, const unsigned char =
*cp,
> +                             const unsigned char *fp, unsigned int count=
);
>         void (*write_wakeup)(struct tty_port *port);
>  };
>
> --
> 2.30.2
>


--=20
With Best Regards,
Andy Shevchenko

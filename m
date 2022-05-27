Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964C2536240
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 14:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239702AbiE0MVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 08:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354307AbiE0MRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 08:17:21 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF285767E
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 05:00:48 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id i9so5572125wrc.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 05:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m8hjobXXscQ5RSJJgp2EcJsmDZ8R3efiq/2P795X5lc=;
        b=LD4NatI+P23lPQT1J4HL+xQvfFWGLXe62ngZTKxQu1JhbU29cpz58Ep7vifYkK8N4b
         yalUMCCNfaIgXTrUPCFiR5UoA5fvbeRJikyhFWmIvMpzZ8TC5dMqi/HlgAdjKIaWW7GC
         d1avkakyPzYpg7FtgxkpwAg1Z7RWovRUozAZq6AR+25FcnJKQEMvWwN4TxQyLkPs+voC
         kmP66WSBHFAmR4IUruQN6HmJ8OYYxeTIyzAcu+fuGvwFcu2SINK0egybQEc7IWpn6tkv
         IcfVQ/3xV4YXPAUpHSg56fBpsdwqi2M0JDXvLQZrUQbZEW01gF4/1NNYgftagWf/kzON
         pwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m8hjobXXscQ5RSJJgp2EcJsmDZ8R3efiq/2P795X5lc=;
        b=fSY6yvPdmp9sWl8WV0q0Jx4Ws2nzU0KNjBVkSFymBrkSBb6iadqHajlM16i6z4H2ur
         udu4xahiD/N4vCaN+79sm3gZwTx7WyAJh0IpT7DXSggdAbIwMTm8EfxndKV1l00FUkZG
         4VUKjS8IBqS3OhijKiNXiCp1KuxxkHn7zQZ0fXPW7WmGFYfZtEhT2bqr+tV4bEU7pb4w
         idG25XXTyF69gmOMbJ3Qzhk08/8v58ED5DqpNggUGaoX6x+A6g28uAvUMpcSsyqPGOmv
         Zq/QH3R39k0U71Jci1yqrWbNi1HxpbsotoDH8AenFrmNHFv67sES2Qtw/4vvbEXiCjxV
         idUw==
X-Gm-Message-State: AOAM531GI4psmGTKi/z3Q+jvYbgFvoDPz9eY7uK2YKSNDdV8qeGJtnQq
        iFwExV+9SsgWlJWAPqX4Cqa0H4qzVI0kKuPsp/vcjTMdFx0=
X-Google-Smtp-Source: ABdhPJzY+F+HmiFTFwFpOr3tX0pyLI1eBA98saDiztWdIv2vJiH46x43SagvfNalG3t8P68ZeiHaNSutXG/DHmixD3M=
X-Received: by 2002:a5d:480c:0:b0:20e:6133:132 with SMTP id
 l12-20020a5d480c000000b0020e61330132mr35657541wrq.593.1653652847198; Fri, 27
 May 2022 05:00:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220512170008.1301613-2-xiehuan09@gmail.com> <202205130923.SJJN7oez-lkp@intel.com>
 <20220518224849.b195cc2380fde43c593d79c5@kernel.org> <CAEr6+EDZ3ekYqWzz-0pmR8C5D_mdWdvHoE2dhycSox=hFKh+8g@mail.gmail.com>
 <20220527084212.337e8f7dda680c7bc179173a@kernel.org>
In-Reply-To: <20220527084212.337e8f7dda680c7bc179173a@kernel.org>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Fri, 27 May 2022 20:00:35 +0800
Message-ID: <CAEr6+EAMi+w_W0MBeoEC9wGMpFggd-BMv53JFxmvj0ELGv3XBQ@mail.gmail.com>
Subject: Re: [PATCH v10 1/4] trace: Add trace any kernel object
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, mingo@redhat.com,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Fri, May 27, 2022 at 7:42 AM Masami Hiramatsu <mhiramat@kernel.org> wrot=
e:
>
> Hi Jeff,
>
> On Wed, 18 May 2022 22:17:50 +0800
> Jeff Xie <xiehuan09@gmail.com> wrote:
>
> >  Hi Masami,
> >
> > Thank you for your reminder, I feel very strange, this patch series
> > was always  based on:
> > https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
> > ftrace/core
> >
> > These compile errors may be because other branches have not merged
> > into Tom's patches.
> > Steve told me before that this patch series should rely on Tom's patch.
>
> OK, when you send the next version, please describe this in the cover
> mail and point Tom's series if it is not merged yet.

Ok, thanks for the reminder.

> Thank you,
>
> >
> >
> > On Wed, May 18, 2022 at 9:48 PM Masami Hiramatsu <mhiramat@kernel.org> =
wrote:
> > >
> > > Hi Jeff,
> > >
> > > Can you fix these errors, since these looks real bugs.
> > >
> > > Thank you,
> > >
> > > On Fri, 13 May 2022 10:01:48 +0800
> > > kernel test robot <lkp@intel.com> wrote:
> > >
> > > > Hi Jeff,
> > > >
> > > > Thank you for the patch! Perhaps something to improve:
> > > >
> > > > [auto build test WARNING on rostedt-trace/for-next]
> > > > [also build test WARNING on v5.18-rc6 next-20220512]
> > > > [If your patch is applied to the wrong git tree, kindly drop us a n=
ote.
> > > > And when submitting patch, we suggest to use '--base' as documented=
 in
> > > > https://git-scm.com/docs/git-format-patch]
> > > >
> > > > url:    https://github.com/intel-lab-lkp/linux/commits/Jeff-Xie/tra=
ce-Introduce-objtrace-trigger-to-trace-the-kernel-object/20220513-010820
> > > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/lin=
ux-trace.git for-next
> > > > config: i386-randconfig-c001 (https://download.01.org/0day-ci/archi=
ve/20220513/202205130923.SJJN7oez-lkp@intel.com/config)
> > > > compiler: clang version 15.0.0 (https://github.com/llvm/llvm-projec=
t 9519dacab7b8afd537811fc2abaceb4d14f4e16a)
> > > > reproduce (this is a W=3D1 build):
> > > >         wget https://raw.githubusercontent.com/intel/lkp-tests/mast=
er/sbin/make.cross -O ~/bin/make.cross
> > > >         chmod +x ~/bin/make.cross
> > > >         # https://github.com/intel-lab-lkp/linux/commit/3c91aa291a0=
fe8b28b02a14827b0c4ca3ebda601
> > > >         git remote add linux-review https://github.com/intel-lab-lk=
p/linux
> > > >         git fetch --no-tags linux-review Jeff-Xie/trace-Introduce-o=
bjtrace-trigger-to-trace-the-kernel-object/20220513-010820
> > > >         git checkout 3c91aa291a0fe8b28b02a14827b0c4ca3ebda601
> > > >         # save the config file
> > > >         mkdir build_dir && cp config build_dir/.config
> > > >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cr=
oss W=3D1 O=3Dbuild_dir ARCH=3Di386 SHELL=3D/bin/bash kernel/trace/
> > > >
> > > > If you fix the issue, kindly add following tag as appropriate
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > >
> > > > All warnings (new ones prefixed by >>):
> > > >
> > > >    kernel/trace/trace_object.c:259:13: error: incompatible function=
 pointer types initializing 'int (*)(struct seq_file *, struct event_trigge=
r_ops *, struct event_trigger_data *)' with an expression of type 'int (str=
uct seq_file *, struct event_trigger_data *)' [-Werror,-Wincompatible-funct=
ion-pointer-types]
> > > >            .print                  =3D trace_object_trigger_print,
> > > >                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > > >    kernel/trace/trace_object.c:260:12: error: incompatible function=
 pointer types initializing 'int (*)(struct event_trigger_ops *, struct eve=
nt_trigger_data *)' with an expression of type 'int (struct event_trigger_d=
ata *)' [-Werror,-Wincompatible-function-pointer-types]
> > > >            .init                   =3D event_object_trigger_init,
> > > >                                      ^~~~~~~~~~~~~~~~~~~~~~~~~
> > > >    kernel/trace/trace_object.c:261:12: error: incompatible function=
 pointer types initializing 'void (*)(struct event_trigger_ops *, struct ev=
ent_trigger_data *)' with an expression of type 'void (struct event_trigger=
_data *)' [-Werror,-Wincompatible-function-pointer-types]
> > > >            .free                   =3D trace_object_trigger_free,
> > > >                                      ^~~~~~~~~~~~~~~~~~~~~~~~~
> > > >    kernel/trace/trace_object.c:266:13: error: incompatible function=
 pointer types initializing 'int (*)(struct seq_file *, struct event_trigge=
r_ops *, struct event_trigger_data *)' with an expression of type 'int (str=
uct seq_file *, struct event_trigger_data *)' [-Werror,-Wincompatible-funct=
ion-pointer-types]
> > > >            .print                  =3D trace_object_trigger_print,
> > > >                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > > >    kernel/trace/trace_object.c:267:12: error: incompatible function=
 pointer types initializing 'int (*)(struct event_trigger_ops *, struct eve=
nt_trigger_data *)' with an expression of type 'int (struct event_trigger_d=
ata *)' [-Werror,-Wincompatible-function-pointer-types]
> > > >            .init                   =3D event_object_trigger_init,
> > > >                                      ^~~~~~~~~~~~~~~~~~~~~~~~~
> > > >    kernel/trace/trace_object.c:268:12: error: incompatible function=
 pointer types initializing 'void (*)(struct event_trigger_ops *, struct ev=
ent_trigger_data *)' with an expression of type 'void (struct event_trigger=
_data *)' [-Werror,-Wincompatible-function-pointer-types]
> > > >            .free                   =3D trace_object_trigger_free,
> > > >                                      ^~~~~~~~~~~~~~~~~~~~~~~~~
> > > > >> kernel/trace/trace_object.c:335:61: warning: format specifies ty=
pe 'long' but the argument has type 'unsigned int' [-Wformat]
> > > >                    pr_err("the size of the %s should be:%ld\n", fie=
ld->name, sizeof(void *));
> > > >                                                         ~~~        =
          ^~~~~~~~~~~~~~
> > > >                                                         %u
> > > >    include/linux/printk.h:489:33: note: expanded from macro 'pr_err=
'
> > > >            printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
> > > >                                   ~~~     ^~~~~~~~~~~
> > > >    include/linux/printk.h:446:60: note: expanded from macro 'printk=
'
> > > >    #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_=
ARGS__)
> > > >                                                        ~~~    ^~~~~=
~~~~~~
> > > >    include/linux/printk.h:418:19: note: expanded from macro 'printk=
_index_wrap'
> > > >                    _p_func(_fmt, ##__VA_ARGS__);                   =
        \
> > > >                            ~~~~    ^~~~~~~~~~~
> > > >    kernel/trace/trace_object.c:356:3: error: implicit declaration o=
f function 'event_trigger_unregister' [-Werror,-Wimplicit-function-declarat=
ion]
> > > >                    event_trigger_unregister(cmd_ops, file, glob+1, =
trigger_data);
> > > >                    ^
> > > >    kernel/trace/trace_object.c:356:3: note: did you mean 'event_tri=
gger_register'?
> > > >    kernel/trace/trace.h:1650:12: note: 'event_trigger_register' dec=
lared here
> > > >    extern int event_trigger_register(struct event_command *cmd_ops,
> > > >               ^
> > > >    kernel/trace/trace_object.c:370:64: error: too few arguments to =
function call, expected 7, have 4
> > > >            ret =3D event_trigger_register(cmd_ops, file, glob, trig=
ger_data);
> > > >                  ~~~~~~~~~~~~~~~~~~~~~~                            =
      ^
> > > >    kernel/trace/trace.h:1650:12: note: 'event_trigger_register' dec=
lared here
> > > >    extern int event_trigger_register(struct event_command *cmd_ops,
> > > >               ^
> > > >    1 warning and 8 errors generated.
> > > >
> > > >
> > > > vim +335 kernel/trace/trace_object.c
> > > >
> > > >    296
> > > >    297        static int
> > > >    298        event_object_trigger_parse(struct event_command *cmd_=
ops,
> > > >    299                               struct trace_event_file *file,
> > > >    300                               char *glob, char *cmd, char *p=
aram_and_filter)
> > > >    301        {
> > > >    302                struct event_trigger_data *trigger_data;
> > > >    303                struct objtrace_trigger_data *obj_data;
> > > >    304                struct ftrace_event_field *field;
> > > >    305                char *objtrace_cmd, *arg;
> > > >    306                char *param, *filter;
> > > >    307                int ret;
> > > >    308                bool remove;
> > > >    309
> > > >    310                remove =3D event_trigger_check_remove(glob);
> > > >    311
> > > >    312                /*
> > > >    313                 * separate the param and the filter:
> > > >    314                 * objtrace:add:OBJ[:COUNT] [if filter]
> > > >    315                 */
> > > >    316                ret =3D event_trigger_separate_filter(param_a=
nd_filter, &param, &filter, true);
> > > >    317                if (ret)
> > > >    318                        return ret;
> > > >    319
> > > >    320                objtrace_cmd =3D strsep(&param, ":");
> > > >    321                if (!objtrace_cmd || strcmp(objtrace_cmd, "ad=
d")) {
> > > >    322                        pr_err("error objtrace command\n");
> > > >    323                        return -EINVAL;
> > > >    324                }
> > > >    325
> > > >    326                arg =3D strsep(&param, ":");
> > > >    327                if (!arg)
> > > >    328                        return -EINVAL;
> > > >    329
> > > >    330                field =3D trace_find_event_field(file->event_=
call, arg);
> > > >    331                if (!field)
> > > >    332                        return -EINVAL;
> > > >    333
> > > >    334                if (field->size !=3D sizeof(void *)) {
> > > >  > 335                        pr_err("the size of the %s should be:=
%ld\n", field->name, sizeof(void *));
> > > >    336                        return -EINVAL;
> > > >    337                }
> > > >    338
> > > >    339                if (remove && !field_exist(file, cmd_ops, fie=
ld->name))
> > > >    340                        return -EINVAL;
> > > >    341
> > > >    342                obj_data =3D kzalloc(sizeof(*obj_data), GFP_K=
ERNEL);
> > > >    343                if (!obj_data)
> > > >    344                        return -ENOMEM;
> > > >    345
> > > >    346                obj_data->field =3D field;
> > > >    347                obj_data->tr =3D file->tr;
> > > >    348                snprintf(obj_data->objtrace_cmd, OBJTRACE_CMD=
_LEN, objtrace_cmd);
> > > >    349
> > > >    350                trigger_data =3D event_trigger_alloc(cmd_ops,=
 cmd, param, obj_data);
> > > >    351                if (!trigger_data) {
> > > >    352                        kfree(obj_data);
> > > >    353                        return -ENOMEM;
> > > >    354                }
> > > >    355                if (remove) {
> > > >    356                        event_trigger_unregister(cmd_ops, fil=
e, glob+1, trigger_data);
> > > >    357                        kfree(obj_data);
> > > >    358                        kfree(trigger_data);
> > > >    359                        return 0;
> > > >    360                }
> > > >    361
> > > >    362                ret =3D event_trigger_parse_num(param, trigge=
r_data);
> > > >    363                if (ret)
> > > >    364                        goto out_free;
> > > >    365
> > > >    366                ret =3D event_trigger_set_filter(cmd_ops, fil=
e, filter, trigger_data);
> > > >    367                if (ret < 0)
> > > >    368                        goto out_free;
> > > >    369
> > > >    370                ret =3D event_trigger_register(cmd_ops, file,=
 glob, trigger_data);
> > > >    371                if (ret)
> > > >    372                        goto out_free;
> > > >    373
> > > >    374                return ret;
> > > >    375
> > > >    376         out_free:
> > > >    377                event_trigger_reset_filter(cmd_ops, trigger_d=
ata);
> > > >    378                kfree(obj_data);
> > > >    379                kfree(trigger_data);
> > > >    380                return ret;
> > > >    381        }
> > > >    382
> > > >
> > > > --
> > > > 0-DAY CI Kernel Test Service
> > > > https://01.org/lkp
> > >
> > >
> > > --
> > > Masami Hiramatsu <mhiramat@kernel.org>
> >
> > Thanks,
> > JeffXie
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,
JeffXie

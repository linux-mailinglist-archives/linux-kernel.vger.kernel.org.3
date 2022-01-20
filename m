Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E588A494FCE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 15:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245443AbiATOGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 09:06:32 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:55490 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241860AbiATOGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 09:06:30 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 79FC7218F9;
        Thu, 20 Jan 2022 14:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642687589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=shTQp7UAWYxgiwzzIMpTtbZXTj9hJvO3jPqV+yzM6Uo=;
        b=BEoIfb2MZNo4XJtpu2F19GgXlyk/T9b6tK4YfHRoYQTTLLY95Tob8alonCYC9IFA+ojG7G
        5Y6OVD1SMJAIZY0ojLJ/Gre4DqMP3ULpysKepXeCU+rvU8oMgz6elTrPspJdYuujFs8+8E
        sHtR804If8Nwm0dpywYChe9nVbzxE5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642687589;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=shTQp7UAWYxgiwzzIMpTtbZXTj9hJvO3jPqV+yzM6Uo=;
        b=m72nlu8ZuiF1I1mMVThN5eFon3qH422OIuF9c9EfJ8vJVARbkN6wDKb1/grw9nZlT6lAOK
        gsCJ2/plRiZx4KAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 64B9A13BCC;
        Thu, 20 Jan 2022 14:06:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uwJJGGVs6WFEEgAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 20 Jan 2022 14:06:29 +0000
Date:   Thu, 20 Jan 2022 15:06:29 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/2] block: hold queue lock while iterating in
 diskstats_show
Message-ID: <20220120140629.ffe26hen5cxwzexi@carbon.lan>
References: <20220120105248.117025-1-dwagner@suse.de>
 <20220120105248.117025-3-dwagner@suse.de>
 <Yelb4+r5KuV67tO0@T590>
 <20220120131936.mlug7nhnoe73abx5@carbon.lan>
 <Yelo1gx5cp1l4npK@T590>
 <20220120140126.ntzvrcmczd7pph75@carbon.lan>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ijztkbnasanat77d"
Content-Disposition: inline
In-Reply-To: <20220120140126.ntzvrcmczd7pph75@carbon.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ijztkbnasanat77d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 20, 2022 at 03:01:27PM +0100, Daniel Wagner wrote:
> On Thu, Jan 20, 2022 at 09:51:18PM +0800, Ming Lei wrote:
> > Then Can you figure out where blk_mq_queue_tag_busy_iter+0x1e4 points to
> > in source code? And what is NULL pointer?

Yes %rax is NULL

> Here we go:
> 
> /usr/src/debug/kernel-default-5.3.18-59.27.1.x86_64/linux-5.3/linux-obj/../include/linux/sbitmap.h: 249
> 0xffffffffb244a254 <blk_mq_queue_tag_busy_iter+484>:    mov    (%rax),%rdx
> 
> 234static inline void __sbitmap_for_each_set(struct sbitmap *sb,
> 235                                          unsigned int start,
> 236                                          sb_for_each_fn fn, void *data)
> 237{
> 238        unsigned int index;
> 239        unsigned int nr;
> 240        unsigned int scanned = 0;
> 241
> 242        if (start >= sb->depth)
> 243                start = 0;
> 244        index = SB_NR_TO_INDEX(sb, start);
> 245        nr = SB_NR_TO_BIT(sb, start);
> 246
> 247        while (scanned < sb->depth) {
> 248                unsigned long word;
> 249                unsigned int depth = min_t(unsigned int,
> 250                                           sb->map[index].depth - nr,
> 251                                           sb->depth - scanned);


forgot to add this

crash> bt
PID: 17640  TASK: ffff956f4a468000  CPU: 13  COMMAND: "iostat"
 #0 [ffffb701aefb7980] machine_kexec at ffffffffba66fb91
 #1 [ffffb701aefb79d8] __crash_kexec at ffffffffba75927d
 #2 [ffffb701aefb7aa0] crash_kexec at ffffffffba75a13d
 #3 [ffffb701aefb7ab8] oops_end at ffffffffba636cdf
 #4 [ffffb701aefb7ad8] no_context at ffffffffba682baf
 #5 [ffffb701aefb7b40] do_page_fault at ffffffffba683e30
 #6 [ffffb701aefb7b70] page_fault at ffffffffbb0012fe
    [exception RIP: blk_mq_queue_tag_busy_iter+484]
    RIP: ffffffffbaa4a254  RSP: ffffb701aefb7c20  RFLAGS: 00010246
    RAX: 0000000000000000  RBX: 0000000000000001  RCX: 0000000000000000
    RDX: ffff954f43c14c00  RSI: ffffffffbaa442c0  RDI: ffff954fb3749010
    RBP: 0000000000000000   R8: 0000000800000000   R9: 00000008ffffffff
    R10: 0000000000000000  R11: 0000000000000000  R12: 0000000000000000
    R13: ffff9567b2200000  R14: ffff954798c09bc0  R15: ffff954798c09c20
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #7 [ffffb701aefb7cb0] blk_mq_in_flight at ffffffffbaa461e5
 #8 [ffffb701aefb7cd0] diskstats_show at ffffffffbaa4f00d
 #9 [ffffb701aefb7e50] seq_read at ffffffffba90df16
#10 [ffffb701aefb7eb0] proc_reg_read at ffffffffba96d789
#11 [ffffb701aefb7ec8] vfs_read at ffffffffba8e4c39
#12 [ffffb701aefb7ef8] ksys_read at ffffffffba8e4fc1
#13 [ffffb701aefb7f38] do_syscall_64 at ffffffffba60538b
#14 [ffffb701aefb7f50] entry_SYSCALL_64_after_hwframe at ffffffffbb00008c
    RIP: 00007f6031f4eb5e  RSP: 00007ffd187a7e88  RFLAGS: 00000246
    RAX: ffffffffffffffda  RBX: 00005577a698c2c0  RCX: 00007f6031f4eb5e
    RDX: 0000000000000400  RSI: 00005577a698f480  RDI: 0000000000000003
    RBP: 00007f603222e300   R8: 0000000000000000   R9: 0000000000000000
    R10: 0000000000000000  R11: 0000000000000246  R12: 000000000000000a
    R13: 0000000000000d68  R14: 00007f603222d700  R15: 0000000000000d68
    ORIG_RAX: 0000000000000000  CS: 0033  SS: 002b


I've tried to figure out the request_pointer from the registers and I
think the pointer is still in %rdi

struct request_queue {
  last_merge = 0x0, 
  elevator = 0x0, 
  stats = 0xffff956f45a9bec0, 
  rq_qos = 0xffff954f54c57558, 
  mq_ops = 0xffffffffc0c27140 <nvme_tcp_mq_ops>, 
  queue_ctx = 0x4151cf2266c0, 
  queue_depth = 0x0, 
  queue_hw_ctx = 0xffff954f43c14c00, 
  nr_hw_queues = 0x50, 
  backing_dev_info = 0xffff953fae3ae800, 
  queuedata = 0xffff953622282800, 
  queue_flags = 0x5041d0, 


--ijztkbnasanat77d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="request_queue.log"

struct request_queue {
  last_merge = 0x0, 
  elevator = 0x0, 
  stats = 0xffff956f45a9bec0, 
  rq_qos = 0xffff954f54c57558, 
  mq_ops = 0xffffffffc0c27140 <nvme_tcp_mq_ops>, 
  queue_ctx = 0x4151cf2266c0, 
  queue_depth = 0x0, 
  queue_hw_ctx = 0xffff954f43c14c00, 
  nr_hw_queues = 0x50, 
  backing_dev_info = 0xffff953fae3ae800, 
  queuedata = 0xffff953622282800, 
  queue_flags = 0x5041d0, 
  pm_only = {
    counter = 0x0
  }, 
  id = 0x61, 
  bounce_gfp = 0x0, 
  queue_lock = {
    {
      rlock = {
        raw_lock = {
          {
            val = {
              counter = 0x0
            }, 
            {
              locked = 0x0, 
              pending = 0x0
            }, 
            {
              locked_pending = 0x0, 
              tail = 0x0
            }
          }
        }
      }
    }
  }, 
  kobj = {
    name = 0xffffffffbb7846be "queue", 
    entry = {
      next = 0xffff954fb3749088, 
      prev = 0xffff954fb3749088
    }, 
    parent = 0xffff95af629a58a0, 
    kset = 0x0, 
    ktype = 0xffffffffbbb56540, 
    sd = 0xffff956563ecd580, 
    kref = {
      refcount = {
        refs = {
          counter = 0x2
        }
      }
    }, 
    state_initialized = 0x1, 
    state_in_sysfs = 0x1, 
    state_add_uevent_sent = 0x0, 
    state_remove_uevent_sent = 0x0, 
    uevent_suppress = 0x0
  }, 
  mq_kobj = 0xffff95720ca05660, 
  integrity = {
    profile = 0x0, 
    flags = 0x0, 
    tuple_size = 0x0, 
    interval_exp = 0x0, 
    tag_size = 0x0
  }, 
  dev = 0x0, 
  rpm_status = RPM_ACTIVE, 
  nr_pending = 0x0, 
  nr_requests = 0x80, 
  dma_pad_mask = 0x0, 
  dma_alignment = 0x7, 
  ksm = 0x0, 
  rq_timeout = 0x1d4c, 
  poll_nsec = 0xffffffff, 
  poll_cb = 0xffff953443cafa00, 
  poll_stat = {{
      mean = 0x0, 
      min = 0x0, 
      max = 0x0, 
      nr_samples = 0x0, 
      batch = 0x0
    }, {
      mean = 0x0, 
      min = 0x0, 
      max = 0x0, 
      nr_samples = 0x0, 
      batch = 0x0
    }, {
      mean = 0x0, 
      min = 0x0, 
      max = 0x0, 
      nr_samples = 0x0, 
      batch = 0x0
    }, {
      mean = 0x0, 
      min = 0x0, 
      max = 0x0, 
      nr_samples = 0x0, 
      batch = 0x0
    }, {
      mean = 0x0, 
      min = 0x0, 
      max = 0x0, 
      nr_samples = 0x0, 
      batch = 0x0
    }, {
      mean = 0x0, 
      min = 0x0, 
      max = 0x0, 
      nr_samples = 0x0, 
      batch = 0x0
    }, {
      mean = 0x0, 
      min = 0x0, 
      max = 0x0, 
      nr_samples = 0x0, 
      batch = 0x0
    }, {
      mean = 0x0, 
      min = 0x0, 
      max = 0x0, 
      nr_samples = 0x0, 
      batch = 0x0
    }, {
      mean = 0x0, 
      min = 0x0, 
      max = 0x0, 
      nr_samples = 0x0, 
      batch = 0x0
    }, {
      mean = 0x0, 
      min = 0x0, 
      max = 0x0, 
      nr_samples = 0x0, 
      batch = 0x0
    }, {
      mean = 0x0, 
      min = 0x0, 
      max = 0x0, 
      nr_samples = 0x0, 
      batch = 0x0
    }, {
      mean = 0x0, 
      min = 0x0, 
      max = 0x0, 
      nr_samples = 0x0, 
      batch = 0x0
    }, {
      mean = 0x0, 
      min = 0x0, 
      max = 0x0, 
      nr_samples = 0x0, 
      batch = 0x0
    }, {
      mean = 0x0, 
      min = 0x0, 
      max = 0x0, 
      nr_samples = 0x0, 
      batch = 0x0
    }, {
      mean = 0x0, 
      min = 0x0, 
      max = 0x0, 
      nr_samples = 0x0, 
      batch = 0x0
    }, {
      mean = 0x0, 
      min = 0x0, 
      max = 0x0, 
      nr_samples = 0x0, 
      batch = 0x0
    }}, 
  timeout = {
    entry = {
      next = 0x0, 
      pprev = 0x0
    }, 
    expires = 0x0, 
    function = 0xffffffffbaa39440, 
    flags = 0x2c
  }, 
  timeout_work = {
    data = {
      counter = 0xfffffffe0
    }, 
    entry = {
      next = 0xffff954fb37493c0, 
      prev = 0xffff954fb37493c0
    }, 
    func = 0xffffffffbaa454f0
  }, 
  icq_list = {
    next = 0xffff954fb37493d8, 
    prev = 0xffff954fb37493d8
  }, 
  blkcg_pols = {0x3}, 
  root_blkg = 0xffff953622281c00, 
  blkg_list = {
    next = 0xffff953622281c08, 
    prev = 0xffff953622281c08
  }, 
  limits = {
    bounce_pfn = 0xfffffffffffff, 
    seg_boundary_mask = 0xffffffff, 
    virt_boundary_mask = 0xfff, 
    max_hw_sectors = 0x800, 
    max_dev_sectors = 0x0, 
    chunk_sectors = 0x0, 
    max_sectors = 0x800, 
    max_segment_size = 0xffffffff, 
    physical_block_size = 0x200, 
    logical_block_size = 0x200, 
    alignment_offset = 0x0, 
    io_min = 0x200, 
    io_opt = 0x0, 
    max_discard_sectors = 0xffffffff, 
    max_hw_discard_sectors = 0xffffffff, 
    max_write_same_sectors = 0x0, 
    max_write_zeroes_sectors = 0x801, 
    max_zone_append_sectors = 0x0, 
    discard_granularity = 0x200, 
    discard_alignment = 0x0, 
    max_segments = 0x101, 
    max_integrity_segments = 0x0, 
    max_discard_segments = 0x100, 
    misaligned = 0x0, 
    discard_misaligned = 0x0, 
    raid_partial_stripes_expensive = 0x0, 
    zoned = BLK_ZONED_NONE
  }, 
  required_elevator_features = 0x0, 
  nr_zones = 0x0, 
  conv_zones_bitmap = 0x0, 
  seq_zones_wlock = 0x0, 
  sg_timeout = 0x0, 
  sg_reserved_size = 0x7fffffff, 
  node = 0xffffffff, 
  blk_trace = 0x0, 
  blk_trace_mutex = {
    owner = {
      counter = 0x0
    }, 
    wait_lock = {
      {
        rlock = {
          raw_lock = {
            {
              val = {
                counter = 0x0
              }, 
              {
                locked = 0x0, 
                pending = 0x0
              }, 
              {
                locked_pending = 0x0, 
                tail = 0x0
              }
            }
          }
        }
      }
    }, 
    osq = {
      tail = {
        counter = 0x0
      }
    }, 
    wait_list = {
      next = 0xffff954fb37494b8, 
      prev = 0xffff954fb37494b8
    }
  }, 
  fq = 0x0, 
  requeue_list = {
    next = 0xffff954fb37494d0, 
    prev = 0xffff954fb37494d0
  }, 
  requeue_lock = {
    {
      rlock = {
        raw_lock = {
          {
            val = {
              counter = 0x0
            }, 
            {
              locked = 0x0, 
              pending = 0x0
            }, 
            {
              locked_pending = 0x0, 
              tail = 0x0
            }
          }
        }
      }
    }
  }, 
  requeue_work = {
    work = {
      data = {
        counter = 0xfffffffe0
      }, 
      entry = {
        next = 0xffff954fb37494f0, 
        prev = 0xffff954fb37494f0
      }, 
      func = 0xffffffffbaa474d0
    }, 
    timer = {
      entry = {
        next = 0x0, 
        pprev = 0x0
      }, 
      expires = 0x0, 
      function = 0xffffffffba6bb050, 
      flags = 0x200040
    }, 
    wq = 0x0, 
    cpu = 0x0
  }, 
  sysfs_lock = {
    owner = {
      counter = 0x0
    }, 
    wait_lock = {
      {
        rlock = {
          raw_lock = {
            {
              val = {
                counter = 0x0
              }, 
              {
                locked = 0x0, 
                pending = 0x0
              }, 
              {
                locked_pending = 0x0, 
                tail = 0x0
              }
            }
          }
        }
      }
    }, 
    osq = {
      tail = {
        counter = 0x0
      }
    }, 
    wait_list = {
      next = 0xffff954fb3749550, 
      prev = 0xffff954fb3749550
    }
  }, 
  sysfs_dir_lock = {
    owner = {
      counter = 0x0
    }, 
    wait_lock = {
      {
        rlock = {
          raw_lock = {
            {
              val = {
                counter = 0x0
              }, 
              {
                locked = 0x0, 
                pending = 0x0
              }, 
              {
                locked_pending = 0x0, 
                tail = 0x0
              }
            }
          }
        }
      }
    }, 
    osq = {
      tail = {
        counter = 0x0
      }
    }, 
    wait_list = {
      next = 0xffff954fb3749570, 
      prev = 0xffff954fb3749570
    }
  }, 
  unused_hctx_list = {
    next = 0xffff954fb3749580, 
    prev = 0xffff954fb3749580
  }, 
  unused_hctx_lock = {
    {
      rlock = {
        raw_lock = {
          {
            val = {
              counter = 0x0
            }, 
            {
              locked = 0x0, 
              pending = 0x0
            }, 
            {
              locked_pending = 0x0, 
              tail = 0x0
            }
          }
        }
      }
    }
  }, 
  mq_freeze_depth = 0x0, 
  bsg_dev = {
    class_dev = 0x0, 
    minor = 0x0, 
    queue = 0x0, 
    ops = 0x0
  }, 
  td = 0xffff954f43c12800, 
  callback_head = {
    next = 0x0, 
    func = 0x0
  }, 
  mq_freeze_wq = {
    lock = {
      {
        rlock = {
          raw_lock = {
            {
              val = {
                counter = 0x0
              }, 
              {
                locked = 0x0, 
                pending = 0x0
              }, 
              {
                locked_pending = 0x0, 
                tail = 0x0
              }
            }
          }
        }
      }
    }, 
    head = {
      next = 0xffff954fb37495d8, 
      prev = 0xffff954fb37495d8
    }
  }, 
  mq_freeze_lock = {
    owner = {
      counter = 0x0
    }, 
    wait_lock = {
      {
        rlock = {
          raw_lock = {
            {
              val = {
                counter = 0x0
              }, 
              {
                locked = 0x0, 
                pending = 0x0
              }, 
              {
                locked_pending = 0x0, 
                tail = 0x0
              }
            }
          }
        }
      }
    }, 
    osq = {
      tail = {
        counter = 0x0
      }
    }, 
    wait_list = {
      next = 0xffff954fb37495f8, 
      prev = 0xffff954fb37495f8
    }
  }, 
  q_usage_counter = {
    count = {
      counter = 0x8000000000000001
    }, 
    percpu_count_ptr = 0x4151cda18fe8, 
    release = 0xffffffffbaa38da0, 
    confirm_switch = 0x0, 
    force_atomic = 0x0, 
    allow_reinit = 0x1, 
    rcu = {
      next = 0x0, 
      func = 0x0
    }
  }, 
  tag_set = 0xffff958f7fe56008, 
  tag_set_list = {
    next = 0xffff958f7fe56118, 
    prev = 0xffff956f479e6ea0
  }, 
  bio_split = {
    bio_slab = 0xffff9530c7c20e00, 
    front_pad = 0x0, 
    bio_pool = {
      lock = {
        {
          rlock = {
            raw_lock = {
              {
                val = {
                  counter = 0x0
                }, 
                {
                  locked = 0x0, 
                  pending = 0x0
                }, 
                {
                  locked_pending = 0x0, 
                  tail = 0x0
                }
              }
            }
          }
        }
      }, 
      min_nr = 0x2, 
      curr_nr = 0x2, 
      elements = 0xffff954fbdb45180, 
      pool_data = 0xffff9530c7c20e00, 
      alloc = 0xffffffffba832460, 
      free = 0xffffffffba832480, 
      wait = {
        lock = {
          {
            rlock = {
              raw_lock = {
                {
                  val = {
                    counter = 0x0
                  }, 
                  {
                    locked = 0x0, 
                    pending = 0x0
                  }, 
                  {
                    locked_pending = 0x0, 
                    tail = 0x0
                  }
                }
              }
            }
          }
        }, 
        head = {
          next = 0xffff954fb37496a0, 
          prev = 0xffff954fb37496a0
        }
      }
    }, 
    bvec_pool = {
      lock = {
        {
          rlock = {
            raw_lock = {
              {
                val = {
                  counter = 0x0
                }, 
                {
                  locked = 0x0, 
                  pending = 0x0
                }, 
                {
                  locked_pending = 0x0, 
                  tail = 0x0
                }
              }
            }
          }
        }
      }, 
      min_nr = 0x2, 
      curr_nr = 0x2, 
      elements = 0xffff954fbdb453f0, 
      pool_data = 0xffff956fbe9a9180, 
      alloc = 0xffffffffba832460, 
      free = 0xffffffffba832480, 
      wait = {
        lock = {
          {
            rlock = {
              raw_lock = {
                {
                  val = {
                    counter = 0x0
                  }, 
                  {
                    locked = 0x0, 
                    pending = 0x0
                  }, 
                  {
                    locked_pending = 0x0, 
                    tail = 0x0
                  }
                }
              }
            }
          }
        }, 
        head = {
          next = 0xffff954fb37496e8, 
          prev = 0xffff954fb37496e8
        }
      }
    }, 
    bio_integrity_pool = {
      lock = {
        {
          rlock = {
            raw_lock = {
              {
                val = {
                  counter = 0x0
                }, 
                {
                  locked = 0x0, 
                  pending = 0x0
                }, 
                {
                  locked_pending = 0x0, 
                  tail = 0x0
                }
              }
            }
          }
        }
      }, 
      min_nr = 0x0, 
      curr_nr = 0x0, 
      elements = 0x0, 
      pool_data = 0x0, 
      alloc = 0x0, 
      free = 0x0, 
      wait = {
        lock = {
          {
            rlock = {
              raw_lock = {
                {
                  val = {
                    counter = 0x0
                  }, 
                  {
                    locked = 0x0, 
                    pending = 0x0
                  }, 
                  {
                    locked_pending = 0x0, 
                    tail = 0x0
                  }
                }
              }
            }
          }
        }, 
        head = {
          next = 0x0, 
          prev = 0x0
        }
      }
    }, 
    bvec_integrity_pool = {
      lock = {
        {
          rlock = {
            raw_lock = {
              {
                val = {
                  counter = 0x0
                }, 
                {
                  locked = 0x0, 
                  pending = 0x0
                }, 
                {
                  locked_pending = 0x0, 
                  tail = 0x0
                }
              }
            }
          }
        }
      }, 
      min_nr = 0x0, 
      curr_nr = 0x0, 
      elements = 0x0, 
      pool_data = 0x0, 
      alloc = 0x0, 
      free = 0x0, 
      wait = {
        lock = {
          {
            rlock = {
              raw_lock = {
                {
                  val = {
                    counter = 0x0
                  }, 
                  {
                    locked = 0x0, 
                    pending = 0x0
                  }, 
                  {
                    locked_pending = 0x0, 
                    tail = 0x0
                  }
                }
              }
            }
          }
        }, 
        head = {
          next = 0x0, 
          prev = 0x0
        }
      }
    }, 
    rescue_lock = {
      {
        rlock = {
          raw_lock = {
            {
              val = {
                counter = 0x0
              }, 
              {
                locked = 0x0, 
                pending = 0x0
              }, 
              {
                locked_pending = 0x0, 
                tail = 0x0
              }
            }
          }
        }
      }
    }, 
    rescue_list = {
      head = 0x0, 
      tail = 0x0
    }, 
    rescue_work = {
      data = {
        counter = 0xfffffffe0
      }, 
      entry = {
        next = 0xffff954fb37497a8, 
        prev = 0xffff954fb37497a8
      }, 
      func = 0xffffffffbaa33ec0
    }, 
    rescue_workqueue = 0x0
  }, 
  debugfs_dir = 0xffff956f64d2efc0, 
  sched_debugfs_dir = 0x0, 
  rqos_debugfs_dir = 0xffff953fae3a6d80, 
  mq_sysfs_init_done = 0x1, 
  cmd_size = 0x0, 
  write_hints = {0x0, 0x0, 0x0, 0x0, 0x0}
}

--ijztkbnasanat77d--
